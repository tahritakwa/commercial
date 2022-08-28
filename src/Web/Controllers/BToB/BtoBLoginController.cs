using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using Persistence;
using Persistence.CatalogEntities;
using Persistence.Repository.Interfaces;
using Services.Catalog.Interfaces;
using Services.Specific.Hubs;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Catalog.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Web.Controllers.BToB
{
    [Route("api/B2B")]

    [AllowAnonymous]
    public class BtoBLoginController : Controller
    {
        private readonly IServiceUser _serviceUser;
        private readonly ILogger<BtoBLoginController> _logger;
        private readonly B2BSettings _appSettings;
        private readonly IServiceMasterUser _serviceMasterUser;
        private readonly IMasterRepository<MasterUserCompany> _entityRepoMasterUserCompany;
        private readonly IMasterCompanyBuilder _masterCompanyBuilder;
        private readonly IServiceMasterCompany _serviceMasterCompany;

        public BtoBLoginController(IOptions<B2BSettings> appSettings,IServiceUser serviceUserB2b, ILogger<BtoBLoginController> logger,
            IServiceMasterUser serviceMasterUser, IMasterRepository<MasterUserCompany> entityRepoMasterUserCompany,
            IMasterCompanyBuilder masterCompanyBuilder, IServiceMasterCompany serviceMasterCompany)
        {
            _appSettings = appSettings.Value;
            _serviceUser = serviceUserB2b;
            _logger = logger;
            _serviceMasterUser = serviceMasterUser;
            _entityRepoMasterUserCompany = entityRepoMasterUserCompany;
            _masterCompanyBuilder = masterCompanyBuilder;
            _serviceMasterCompany = serviceMasterCompany;
        }

        [Route("getUserWithAssociatedCompanies")]
        [HttpPost]
        [AllowAnonymous]
        public ResponseData GetUserWithAssociatedCompanies([FromBody]string email)
        {
            MasterUserViewModel user = _serviceMasterUser.FindModelsByNoTracked(x => x.Email == email && x.IsBtoB == true).FirstOrDefault();
            if (user == null)
            {
                throw new CustomException(CustomStatusCode.WRONG_EMAIL);
            }
            return new ResponseData()
            {
                listObject = new ListObject()
                {
                    listData = _entityRepoMasterUserCompany.QuerableGetAll()
                .Include(x => x.IdMasterUserNavigation)
                .Include(x => x.IdMasterCompanyNavigation)
                .Where(x => x.IdMasterUserNavigation.Email == email)
                .Select(x => _masterCompanyBuilder.BuildEntity(x.IdMasterCompanyNavigation)).ToList()
                },
                objectData = user.LastConnectedCompany
            };
        }
        [Route("sign")]
        [HttpPost]
        [AllowAnonymous]
        public async Task<object> Signin([FromBody]UserViewModel login)
        {
            try
            {
                if (!string.IsNullOrEmpty(login.Email) && !string.IsNullOrEmpty(login.Password))
                {
                    var conxString = ManageDBConnections.BuildConnectionString(_serviceMasterCompany.GetCompanyDbSettings(login.LastConnectedCompany));
                    CredentialsViewModel credential = _serviceUser.LoginB2b(login, conxString);

                    if (credential != null)
                    {
                        HttpContext.Session.SetObject(Constants.CREDENTIALS, credential);
                        AppHttpContext.Current.Session.SetString(Constants.CONNECTION_STRING, conxString);
                        credential.LastConnectedCompany = login.LastConnectedCompany;
                        MasterUserViewModel user = _serviceMasterUser.FindByAsNoTracking(x => x.Email == login.Email).FirstOrDefault();
                        if (user.LastConnectedCompany != login.LastConnectedCompany)
                        {
                            user.LastConnectedCompany = login.LastConnectedCompany;
                            _serviceMasterUser.UpdateModelWithoutTransaction(user, null, null);
                        }
                        BaseHub hub = new BaseHub();
                        var connectedUsers = hub.GetConnectedUsers();
                        if (connectedUsers.Any(x => x != null && x.UserMail == credential.Email))
                        {
                            throw new CustomException(CustomStatusCode.USER_ALREADY_CONNECTED);
                        }
                        else
                        {
                            GenerateB2BToken(credential);

                            if (credential.Token != null)
                            {
                                string permissions = AppHttpContext.Current.Session.GetString("permissions");
                                List<string>  listPermissions = JsonConvert.DeserializeObject<List<string>>(permissions);
                                HttpContext.Session.SetString("rolesB2b", JsonConvert.SerializeObject(permissions));
                                return credential;
                            }
                            else return Unauthorized();
                        }
                    }
                    else
                    {
                        return new CredentialsModel { Message = "Failed" };
                    }
                }
                else
                {
                    return new CredentialsModel { Message = "Bad Request" };
                }
            }
            catch (CustomException e)
            {
                ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                exceptionLogger.ExceptionObject("LogginController", e);
                throw;
            }
            catch (Exception e)
            {
                ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                exceptionLogger.ExceptionObject("LogginController", e);
                return new CredentialsModel { Message = "Failed" };
            }

        }

        private void GenerateB2BToken(CredentialsViewModel credentialsModel)
        {
            var key = Encoding.ASCII.GetBytes(_appSettings.EncryptionKey);
            ClaimsIdentity claimsIdentity = new ClaimsIdentity(new[]
                {
                    new System.Security.Claims.Claim(ClaimTypes.Name, credentialsModel.Email),
                    new System.Security.Claims.Claim(ClaimTypes.Role, "Authorize")
                }, CookieAuthenticationDefaults.AuthenticationScheme);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Issuer = _appSettings.JWTAuthenticationValidIssuer,
                Audience = _appSettings.JWTAuthenticationValidAudience,
                Subject = claimsIdentity,
                Expires = DateTime.UtcNow.AddDays(NumberConstant.Seven),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            ClaimsPrincipal claimsPrincipal = new ClaimsPrincipal(new[] { claimsIdentity });
            HttpContext.User = claimsPrincipal;
            JwtSecurityTokenHandler tokenHandler = new JwtSecurityTokenHandler();
            var token = tokenHandler.CreateToken(tokenDescriptor);
            credentialsModel.Token = tokenHandler.WriteToken(token);
        }
    }
}