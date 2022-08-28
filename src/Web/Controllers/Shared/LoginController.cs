using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using Serilog.Events;
using Services.Catalog.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Catalog.Interfaces;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

// For more information on enabling Web API for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace Web.Controllers.Shared
{
    [Route("api/login")]
    public class LoginController : Controller
    {
        private readonly ILogger<LoginController> _logger;
        private readonly AppSettings _appSettings;
        public readonly IServiceProvider _serviceProvider;
        public readonly IServiceUser _serviceUser;
        public readonly IServiceCompany _serviceCompany;
        public readonly IServiceMasterUser _serviceMasterUser;
        public readonly IMasterCompanyBuilder _masterCompanyBuilder;
        public readonly IMasterDbSettingsBuilder _masterDbSettingsBuilder;
        public readonly IServiceMasterCompany _serviceMasterCompany;
        private readonly ICredentialsBuilder _credentialbuilder;
        IHttpContextAccessor _httpContextAccessor = null;

        public LoginController(IServiceMasterUser serviceMasterUser, IServiceProvider serviceProvider, IOptions<AppSettings> appSettings,
            IServiceUser serviceUser, ILogger<LoginController> logger, IServiceCompany serviceCompany,
            IMasterCompanyBuilder masterCompanyBuilder, IMasterDbSettingsBuilder masterDbSettingsBuilder, IServiceMasterCompany serviceMasterCompany,
            ICredentialsBuilder credentialbuilder, IHttpContextAccessor httpContextAccessor)
        {
            _serviceProvider = serviceProvider;
            _serviceUser = serviceUser;
            _appSettings = appSettings.Value;
            _logger = logger;
            _serviceCompany = serviceCompany;
            _serviceMasterUser = serviceMasterUser;
            _masterCompanyBuilder = masterCompanyBuilder;
            _masterDbSettingsBuilder = masterDbSettingsBuilder;
            _serviceMasterCompany = serviceMasterCompany;
            _credentialbuilder = credentialbuilder;
            _httpContextAccessor = httpContextAccessor;
        }

        [Route("getCompanyList")]
        [HttpGet]
        public IEnumerable<ReducedCompany> GetCompanyList()
        {
            return _serviceMasterUser.GetCompanyList();
        }
        byte[] FromBase64Url(string base64Url)
        {
            string padded = base64Url.Length % 4 == 0
                ? base64Url : base64Url + "====".Substring(base64Url.Length % 4);
            string base64 = padded.Replace("_", "/")
                                  .Replace("-", "+");
            return Convert.FromBase64String(base64);
        }

        [AllowAnonymous]
        [HttpPost("setDotNetSessionInformationB2B")]
        public object SetDotNetSessionInformationB2B([FromBody] dynamic dataLogin)
        {
            try
            {
                var data = dataLogin.token;
                string jwt = data.ToString().Replace("Bearer ", string.Empty);
                return SetSessionInformation(jwt);
            }
            catch (Exception e)
            {
                GenericLogger.LogMessageAndException(Constants.LOGIN_LOG_FILE_NAME, LogEventLevel.Error,
                         dataLogin, e);
                throw new CustomException(CustomStatusCode.SessionExpired);
            }
        }





        [HttpPost, Route("changeCompany")]
        public bool ChangeCompany([FromBody] string companyCode)
        {
            _serviceMasterUser.CheckExpiredDate(companyCode);
            _serviceCompany.ResetCacheCurrentCompany();
            _serviceMasterUser.UpdateCurrentUserCompanyInMemoryCach(companyCode);
            return true;
        }

        public object SetSessionInformation(string jwt, string companyCode = null)
        {
            JwtSecurityToken token = new JwtSecurityToken(jwt);
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
            CredentialsViewModel user = JsonConvert.DeserializeObject<CredentialsViewModel>(token.Payload["user"].ToString());
            var connectionString = _serviceMasterCompany.GetCompanyDbSettings(user.LastConnectedCompany);
            string generatedConnectionString = ManageDBConnections.BuildConnectionString(connectionString, _appSettings.DbSettings);
            CredentialsViewModel credentialsModel = _serviceUser.SetDotNetSessionInformation(user, generatedConnectionString);
            HttpContext.Session.SetObject(Constants.CREDENTIALS, credentialsModel);
            EnvUrl envUrl = new EnvUrl()
            {
                BaseUrl = _appSettings.BaseUrl,
                checkPermissionJavaApi = _appSettings.checkPermissionJavaApi
            };
            HttpContext.Session.SetString(Constants.ENVURL, JsonConvert.SerializeObject(envUrl));
            // create the object to send it
            dynamic userToReturn = new ExpandoObject();
            userToReturn.IdUser = user.IdUser;
            userToReturn.Email = user.Email;
            userToReturn.LastConnectedCompany = credentialsModel.LastConnectedCompany;
            userToReturn.LastConnectedCompanyId = _serviceCompany.GetMasterCompanyId(user.LastConnectedCompany);
            userToReturn.FirstName = user.FirstName;
            userToReturn.LastName = user.LastName;
            userToReturn.IdTiers = credentialsModel.IdTiers;
            userToReturn.Login = user.Login;
            dynamic objectToReturn = new ExpandoObject();
            objectToReturn.Language = user.Language;
            if (companyCode != null)
            {
                objectToReturn.CodeCompany = companyCode;
            }
            else
            {
                objectToReturn.CodeCompany = user.LastConnectedCompany;
            }
            objectToReturn.activityArea = credentialsModel.ActivityArea;
            objectToReturn.User = userToReturn;
            // Updates the last connection time and the user's connection Ip address
            _serviceUser.UpdateUserLastConnectionInformations(credentialsModel.Email, HttpContext.Connection.RemoteIpAddress);
            string logObject = JsonConvert.SerializeObject(objectToReturn);
            GenericLogger.LogMessage(Constants.LOGIN_LOG_FILE_NAME, LogEventLevel.Information, logObject);
            return objectToReturn;
        }


        [Route("logOut")]
        [HttpPost]
        [AllowAnonymous]
        public ResponseData Logout()
        {
            _serviceCompany.ResetCacheCurrentCompany();
            HttpContext.Session.Remove(Constants.CREDENTIALS);
            HttpContext.Session.Remove(Constants.CONNECTION_STRING);
            HttpContext.Session.Remove(Constants.ROLES);
            HttpContext.Session.Remove(Constants.ROLE_CONFIGS);
            HttpContext.Session.Remove(Constants.IS_SUPER_ADMIN);
            HttpContext.Session.Remove(Constants.REDUCED_ROLE_CONFIGS_MODULES_FUNCS);
            HttpContext.Session.Clear();
            return new ResponseData();
        }

        [Route("encode")]
        [HttpPost]
        public object Encode([FromBody] CredentialsModel input)
        {
            try
            {
                if (input != null)
                {
                    input.Password = "";
                    string json = JsonConvert.SerializeObject(input);
                    string base64Encoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(json));
                    return new { token = base64Encoded };
                }
                else
                {
                    return null;
                }
            }
            catch
            {
                return null;
            }
        }

        [Route("Unauth")]
        [HttpGet]
        [AllowAnonymous]
        public object Unauth()
        {
            return Unauthorized();
        }

        [Route("Forbidden")]
        [HttpGet]
        [AllowAnonymous]
        public object Forbidden()
        {
            return Forbid();
        }
        //
        // Summary:
        //     Creates a Microsoft.AspNetCore.Mvc.ForbidResult (Microsoft.AspNetCore.Http.StatusCodes.Status403Forbidden
        //     by default).
        //
        // Returns:
        //     The created Microsoft.AspNetCore.Mvc.ForbidResult for the response.
        //
        // Remarks:
        //     Some authentication schemes, such as cookies, will convert Microsoft.AspNetCore.Http.StatusCodes.Status403Forbidden
        //     to a redirect to show a login page.
        [NonAction]
        public override ForbidResult Forbid()
        {
            var props = new AuthenticationProperties
            {
                RedirectUri = ""
            };
            return new ForbidResult(props);
        }
        /// <summary>
        /// Get enviroment name
        /// </summary>
        /// <returns></returns>
        [HttpGet("getEnvName")]
        [AllowAnonymous]
        public dynamic GetEnvName()
        {
            string envName;
            using (StreamReader r = new StreamReader($"./Env/env.json"))
            {
                string json = r.ReadToEnd();
                dynamic dataEnv = JsonConvert.DeserializeObject<dynamic>(json);
                envName = dataEnv.EnviromentName.Value;
            };
            dynamic sampleObject = new ExpandoObject();
            sampleObject.envName = envName;
            return sampleObject;

        }
        ///// <summary>
        ///// validate recaptcha Token from google-recaptcha api
        ///// </summary>
        ///// <param name="secretKey"></param>
        ///// <returns></returns>
        //[AllowAnonymous]
        //[HttpPost("ValidateRecaptchaToken")]
        //public dynamic ValidateRecaptchaToken([FromBody] string secretKey)
        //{
        //    bool result = _serviceSettingsService.ValidateRecaptchaToken(secretKey);
        //    dynamic sampleObject = new ExpandoObject();
        //    sampleObject.result = result;
        //    return sampleObject;

        //}
    }
}
