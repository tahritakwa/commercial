using log4net;
using log4net.Config;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Primitives;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using Persistence;
using Services.Catalog.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Data.SqlClient;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using ViewModels.Comparers;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Utils;
using Web.Interceptors.Proxy;

namespace Web.Interceptors.RequestInterceptor
{
    /// <summary>
    /// Exception Handler middleware 
    /// </summary>
    public class RequestInterceptorMiddleware
    {
        #region Fields
        /// <summary>
        /// RequestDelegate
        /// </summary>
        private readonly RequestDelegate _next;
        /// <summary>
        /// logger
        /// </summary>
        private readonly ILogger<RequestInterceptorMiddleware> _logger;
        private readonly string _reportingServiceUrl;
        private readonly IMemoryCache _memoryCache;
        private readonly AppSettings _appSettings;
        public readonly IServiceMasterCompany _serviceMasterCompany;
        public readonly IServiceUser _serviceUser;
        public readonly IServiceMasterUser _serviceMasterUser;
        private static readonly object lockObject1 = new object();
        private static readonly object lockObject2 = new object();
        private static readonly object lockObject3 = new object();
        #endregion
        /// <summary>
        /// 
        /// </summary>
        /// <param name="next"></param>
        /// <param name="logger"></param>
        public RequestInterceptorMiddleware(RequestDelegate next, ILogger<RequestInterceptorMiddleware> logger, IMemoryCache memoryCache, IOptions<AppSettings> appSettings,
            IServiceMasterCompany serviceMasterCompany, IServiceUser serviceUser, IServiceMasterUser serviceMasterUser)
        {
            _logger = logger;
            _next = next;
            _reportingServiceUrl = "";
            _memoryCache = memoryCache;
            _appSettings = appSettings.Value;
            _serviceMasterCompany = serviceMasterCompany;
            _serviceUser = serviceUser;
            _serviceMasterUser = serviceMasterUser;
        }

        #region Methodes
        /// <summary>
        /// Invoke request
        /// </summary>
        /// <param name="httpContext"></param>
        /// <returns></returns>
        public async Task InvokeAsync(HttpContext httpContext)
        {
            ILog _actionLogger = LogManager.GetLogger("ActionLogger");
            try
            {

                string requestPath = httpContext.Request.Path.ToString();
             

                if (requestPath.Contains("/getEnvName"))
                {
                    await _next(httpContext);
                    return;
                }
                httpContext.Request.Headers.TryGetValue("Telerik", out StringValues isTelerik);
                if (isTelerik.ToString() == "Telerik")
                {
                    httpContext.Request.Headers.TryGetValue("user", out StringValues telerikUser);
                    var TelerikToken = _memoryCache.Get("Telerik/" + telerikUser.ToString());
                    httpContext.Request.Headers.Add("Authorization", TelerikToken.ToString());
                    await _next(httpContext);
                    return;
                }
                var TokenInfo = ValidateAndDecryptToken(httpContext);
                MasterUserViewModel user = null;
                if (TokenInfo == null)
                {
                    return;
                }
                else if (httpContext.Request.Headers.TryGetValue("CodeCompany", out StringValues CodeCompany))
                {
                    user = JsonConvert.DeserializeObject<MasterUserViewModel>(TokenInfo["user"].ToString());
                    SetConnexionStringAndUserCurrentCompanyCodeFromBTob(CodeCompany, user, httpContext);
                }
                else
                {
                    user = JsonConvert.DeserializeObject<MasterUserViewModel>(TokenInfo["user"].ToString());
                    SetConnexionStringAndUserCurrentCompanyCode(user.Email, httpContext);
                }
                SetEnvUrl(httpContext);
                if (requestPath.Contains("/api/webreports") || requestPath.Contains("/api/reports"))
                {
                    ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                    exceptionLogger.ExceptionMethodSimpleMessage("Reporting request path <" + requestPath + ">");
                    var proxyService = httpContext.RequestServices.GetRequiredService<ProxyService>();
                    using (var requestMessage = httpContext.CreateProxyHttpRequest(new Uri(_reportingServiceUrl + requestPath)))
                    {
                        if (requestMessage.Content != null && requestPath.EndsWith("/instances"))
                        {
                            var requestContent = JsonConvert.DeserializeObject<TelerikReportSource>(requestMessage.Content.ReadAsStringAsync().Result);
                            if (requestContent != null)
                            {
                                requestContent.Parameters.Url = _appSettings.BaseUrl.AbsoluteUri;
                                requestContent.Parameters.User = _memoryCache.Get("CurrentUserMail") as string;
                                var stringContent = new StringContent(JsonConvert.SerializeObject(requestContent), Encoding.UTF8, "application/json");
                                requestMessage.Content = stringContent;
                            }
                        }
                        var prepareRequestHandler = proxyService.Options.PrepareRequest;
                        if (prepareRequestHandler != null)
                        {
                            await prepareRequestHandler(httpContext.Request, requestMessage);
                        }
                        using (var responseMessage = await httpContext.SendProxyHttpRequest(requestMessage))
                        {
                            await httpContext.CopyProxyHttpResponse(responseMessage);
                        }
                        exceptionLogger.ExceptionMethodSimpleMessage("End Reporting request path <" + requestPath + ">");
                    }
                }
                else if (requestPath.Contains("printwebreports/"))
                {
                    var proxyService = httpContext.RequestServices.GetRequiredService<ProxyService>();
                    httpContext.Request.Headers.TryGetValue("User", out StringValues userMails);
                    var usermail = userMails.ToString();
                    bool getSessionResult = _memoryCache.TryGetValue(usermail, out var memcacheValue);
                    memcacheValue = getSessionResult ? memcacheValue : _memoryCache.TryGetValue(usermail.ToLower(), out memcacheValue);
                    httpContext.Session = memcacheValue as ISession;
                    using (var requestMessage = httpContext.CreateProxyHttpRequest(new Uri(_appSettings.BaseUrl.AbsoluteUri + requestPath.Replace("/api/printwebreports", "api"))))
                    {

                        var prepareRequestHandler = proxyService.Options.PrepareRequest;
                        if (prepareRequestHandler != null)
                        {
                            await prepareRequestHandler(httpContext.Request, requestMessage);
                        }

                        using (var responseMessage = await httpContext.SendProxyHttpRequest(requestMessage))
                        {
                            await httpContext.CopyProxyHttpResponse(responseMessage);
                        }
                    }
                }
                else
                {
                    await _next(httpContext);
                }
            }
            catch (Exception ex)
            {
                var index = ex.StackTrace.IndexOf(Constants.LINE_EXCEPTION) + NumberConstant.Ten;
                var actionInfo = new ActionLoggerInfo()
                {
                Controller = ((CustomException)ex).Paramtrs != null && ((CustomException)ex).Paramtrs.Count > 0 ? ((CustomException)ex).Paramtrs.ToArray().FirstOrDefault() : String.Empty,
                Method = ((CustomException)ex).SpecificMessage != null ? ((CustomException)ex).SpecificMessage.ToString() : String.Empty,
                ActionOriginalMessage = ((CustomException)ex).OriginalException != null ? ((CustomException)ex).OriginalException.Message : String.Empty,
                ExceptionDetails = ex.GetType().ToString(),
                ExceptionLine = index != 0 ? ex.StackTrace.Substring(0, index) : String.Empty,
                };
                _actionLogger.Error(actionInfo);

                //ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                if (ex.GetType().GetProperty("OriginalException") != null && ex.GetType().GetProperty("OriginalException").GetValue(ex, null) != null)
                {
                    Exception e = (Exception)ex.GetType().GetProperty("OriginalException").GetValue(ex, null);
                    //exceptionLogger.ExceptionObject(e.Source, e);
                }
                else
                {
                    //exceptionLogger.ExceptionObject(ex.Source, ex);
                }
                await HandleExceptionAsync(httpContext, ex);
            }
        }



        public void SetConnexionStringAndUserCurrentCompanyCode(string userMail, HttpContext httpContext)
        {
            
            var companyCode = _memoryCache.Get(userMail);
            if (companyCode == null)
            {
                string LastConnectedCompany;
                lock (lockObject1)
                {
                    if (companyCode == null)
                    {
                        LastConnectedCompany = _serviceMasterUser.GetModelAsNoTracked(x => x.Email == userMail).LastConnectedCompany;
                        _memoryCache.Set(userMail, LastConnectedCompany);
                        companyCode = LastConnectedCompany;
                    }
                }
            }
            DbSettings companySetting = _memoryCache.Get(companyCode) as DbSettings;
            if (companySetting == null)
            {
                lock (lockObject2)
                {
                    if (companySetting == null)
                    {
                        companySetting = _serviceMasterCompany.GetCompanyDbSettings(companyCode.ToString());
                        _memoryCache.Set(companyCode.ToString(), companySetting);
                    }
                }
            }

            var telerikUser = _memoryCache.Get("Telerik/" + userMail);
            if (telerikUser == null)
            {
                lock (lockObject3)
                {
                    if (telerikUser == null)
                    {
                        httpContext.Request.Headers.TryGetValue("Authorization", out StringValues authorization);
                        _memoryCache.Set("Telerik/" + userMail, authorization);
                    }
                }
            }
        }

        public void SetEnvUrl(HttpContext httpContext)
        {
            EnvUrl envUrl = new EnvUrl()
            {
                BaseUrl = _appSettings.BaseUrl,
                checkPermissionJavaApi = _appSettings.checkPermissionJavaApi
            };
            httpContext.Request.Headers.Add("envUrl", JsonConvert.SerializeObject(envUrl).ToString());

        }


        /// <summary>
        /// Check if a call is from B2B
        /// </summary>
        /// <param name="requestPath"></param>
        /// <returns></returns>
        public bool IsFromB2B(HttpContext httpContext)
        {
            httpContext.Request.Headers.TryGetValue("ProjectName", out StringValues requestOrigin);
            return requestOrigin == "B2BProject";
        }

        /// <summary>
        /// Handle Exception Async Methode
        /// </summary>
        /// <param name="context"></param>
        /// <param name="exception"></param>
        /// <returns></returns>
        private static Task HandleExceptionAsync(HttpContext context, Exception exception)
        {
            context.Response.ContentType = "application/json";

            ResponseData responseData = new ResponseData();
            if (exception.GetType().GetProperty("StatusCode") != null && exception.GetType().GetProperty("StatusCode").GetValue(exception, null) != null)
            {
                responseData.customStatusCode = (CustomStatusCode)exception.GetType().GetProperty("StatusCode").GetValue(exception, null);
                responseData.objectData = ((CustomException)exception).Paramtrs;
            }
            else if (exception.GetType() == typeof(SqlException))
            {
                responseData.customStatusCode = CustomStatusCode.DbConnectionError;
            }
            else
            {
                responseData.customStatusCode = (CustomStatusCode)HttpStatusCode.InternalServerError;
            }
            return context.Response.WriteAsync(responseData.ToString());
        }
        #endregion


        public dynamic ValidateAndDecryptToken(HttpContext httpContext)
        {
            httpContext.Request.Headers.TryGetValue("Authorization", out StringValues userToken);
            if (userToken != "")
            {
                var jwt = userToken.ToString().Replace("Bearer ", string.Empty);
                if (jwt == "null" || jwt == "")
                {
                    return null;
                }
                var rsaProvider = RSA.Create();
                rsaProvider.ImportParameters(
                  new RSAParameters()
                  {
                      Modulus = FromBase64Url(_appSettings.PublicKey.Modulus),
                      Exponent = FromBase64Url(_appSettings.PublicKey.Exponent)
                  });
                var validationParameters = new TokenValidationParameters
                {
                    RequireExpirationTime = true,
                    RequireSignedTokens = true,
                    ValidateAudience = false,
                    ValidateIssuer = false,
                    ValidateLifetime = false,
                    IssuerSigningKey = new RsaSecurityKey(rsaProvider)
                };
                var handler = new JwtSecurityTokenHandler();
                handler.ValidateToken(jwt, validationParameters, out SecurityToken validatedToken);
                if (userToken != "")
                {
                    JwtSecurityToken token = new JwtSecurityToken(jwt);
                    return token.Payload;
                }
                return null;
            }
            return null;
        }


        byte[] FromBase64Url(string base64Url)
        {
            string padded = base64Url.Length % 4 == 0
                ? base64Url : base64Url + "====".Substring(base64Url.Length % 4);
            string base64 = padded.Replace("_", "/")
                                  .Replace("-", "+");
            return Convert.FromBase64String(base64);
        }
        public void SetConnexionStringAndUserCurrentCompanyCodeFromBTob(string CodeCompany, MasterUserViewModel user, HttpContext httpContext)
        {
            string LastConnectedCompany;
            var companyCode = CodeCompany;
            if (companyCode == null)
            {
                
                lock (lockObject1)
                {
                    if (companyCode == null)
                    {
                        LastConnectedCompany = _serviceMasterUser.GetModelAsNoTracked(x => x.Email == user.Email).LastConnectedCompany;
                        _memoryCache.Set(user.Email, LastConnectedCompany);
                        companyCode = LastConnectedCompany;
                    }
                }
            }
            DbSettings companySetting = _memoryCache.Get(companyCode) as DbSettings;
            if(companySetting != null) {
            _memoryCache.Set(companyCode.ToString(), companySetting);
            _memoryCache.Set("companySetting", companySetting);
            _memoryCache.Set(user.Email, CodeCompany);
            }else if (companySetting == null)
            {
                lock (lockObject2)
                {
                    if (companySetting == null)
                    {
                        companySetting = _serviceMasterCompany.GetCompanyDbSettings(companyCode.ToString());
                        _memoryCache.Set(companyCode.ToString(), companySetting);
                        _memoryCache.Set("companySetting", companySetting);
                        LastConnectedCompany = companyCode;
                        _memoryCache.Set(user.Email, LastConnectedCompany);
                    }
                }
            }
        }
    }
}
