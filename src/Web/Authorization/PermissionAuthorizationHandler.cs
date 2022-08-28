using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Serilog.Events;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Shared;

namespace Web.Authorization
{
    internal class PermissionAuthorizationHandler : AuthorizationHandler<PermissionRequirement>
    {
        const string LIST = "LIST";
        const string ADD = "ADD";
        const string DELETE = "DELETE";
        const string UPDATE = "UPDATE";
        const string PRINT = "PRINT";
        const string DROPDOWNLIST = "DROPDOWNLIST";
        const string IMPORT = "IMPORT";
        const string SHOW = "SHOW";

        IHttpContextAccessor _httpContextAccessor = null;
        private readonly AppSettings _appSettings;
        private readonly IServiceUser _serviceUser;
        public PermissionAuthorizationHandler(IHttpContextAccessor httpContextAccessor, IOptions<AppSettings> appSettings,
            IServiceUser serviceUser)
        {
            _httpContextAccessor = httpContextAccessor;
            _appSettings = appSettings.Value;
            _serviceUser = serviceUser;
        }
        /// <summary>
        /// verify if the request has permission
        /// </summary>
        /// <param name="context"></param>
        /// <param name="requirement"></param>
        /// <returns></returns>
        protected override async Task HandleRequirementAsync(AuthorizationHandlerContext context, PermissionRequirement requirement)
        {

            HttpContext httpContext = _httpContextAccessor.HttpContext;
            List<string> permissionsList = new List<string>();
            if (requirement != null && requirement.Permission != null)
            {
                foreach (PermissionRequirement permission in context.Requirements)
                {
                    if (permission.Permission.Contains(","))
                    {
                        string permissionString = permission.Permission.Replace(" ", "");
                        permissionsList.AddRange(permissionString.Split(","));


                    }
                    else
                    {
                        permissionsList.Add(permission.Permission);
                    }
                }
            }
            else
            {
                foreach (PermissionRequirement permission in context.Requirements)
                {
                    permissionsList.Add(permission.Permission);
                }
            }


            IList<string> permissionPrefix = new List<string> { LIST, ADD, DELETE, UPDATE, PRINT, DROPDOWNLIST, IMPORT, SHOW };
            string basePermission = "";
            if (permissionsList.Any(x => permissionPrefix.Any(y => x == y)))
            {
                httpContext.Request.Headers.TryGetValue("TModel", out StringValues modelValue);
                string entityName = modelValue.First();
                basePermission = new StringBuilder(permissionsList.Where(item => permissionPrefix.Any(one => one == item)).FirstOrDefault()).
                    Append("_").Append(entityName.ToUpper()).ToString();
                permissionsList.Remove(permissionsList.Where(item => permissionPrefix.Any(x => x == item)).FirstOrDefault());
                permissionsList.Add(basePermission);
            }
            var jwt = httpContext.Request.Headers["Authorization"].ToString().Replace("Bearer ", string.Empty);
            JwtSecurityToken token = null;
            ClaimsPrincipal claimsPrincipal = new ClaimsPrincipal();
            try
            {
                token = new JwtSecurityToken(jwt);
                CredentialsModel user = JsonConvert.DeserializeObject<CredentialsModel>(token.Payload["user"].ToString());
                UserViewModel userViewModel = _serviceUser.GetModelAsNoTracked(x => x.Email.ToLower().Equals(user.Email.ToLower()));
                if (userViewModel != null && !userViewModel.IsActif.Value)
                {
                    throw new CustomException(CustomStatusCode.USER_WITH_EMAIL_NOT_ACTIVE);
                }
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw;
            }
            using (HttpClient httpClient = new HttpClient())
            {
                httpClient.BaseAddress = _appSettings.MasterUrl;
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(_appSettings.MasterMediaType));
                httpClient.DefaultRequestHeaders.Add("Origin", _appSettings.BaseUrl.ToString());
                httpClient.DefaultRequestHeaders.Add("Authorization", "Bearer " + jwt.ToString());
                HttpResponseMessage response = await httpClient.PostAsync(_appSettings.checkPermissionJavaApi, new StringContent(JsonConvert.SerializeObject(permissionsList), Encoding.UTF8, _appSettings.MasterMediaType))
                    .ConfigureAwait(continueOnCapturedContext: false);
                object responseData = JsonConvert.DeserializeObject(response.Content.ReadAsStringAsync().Result);
                string requestPath = httpContext.Request.Path.ToString();
                if (response.StatusCode == System.Net.HttpStatusCode.OK && (bool)responseData)
                {
                    context.Succeed(requirement);
                   
                }
                else
                {
                    GenericLogger.LogMessage(Constants.HAS_PERMISSION_FILE_NAME, LogEventLevel.Information, requestPath + "+" + responseData.ToString());
                    context.Fail();

                    throw new CustomException(CustomStatusCode.Unauthorized);
                }
            }
        }
        byte[] FromBase64Url(string base64Url)
        {
            string padded = base64Url.Length % 4 == 0
                ? base64Url : base64Url + "====".Substring(base64Url.Length % 4);
            string base64 = padded.Replace("_", "/")
                                  .Replace("-", "+");
            return Convert.FromBase64String(base64);
        }

    }
}
