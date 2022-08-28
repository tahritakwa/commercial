using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using Persistence;
using Services.Catalog.Interfaces;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.MasterViewModels;
using ViewModels.DTO.Models;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;
using Web.Controllers.Shared.Interfaces;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/user")]
    public class UserController : BaseController, IUserController
    {
        private readonly IServiceUser _serviceUser;
        private readonly IServiceInformation _serviceInformation;
        private readonly IServiceMsgNotification _serviceMsgNotification;
        private readonly SmtpSettings _smtpSettings;
        private readonly IServiceMasterUser _serviceMasterUser;
        private readonly IServiceMasterCompany _serviceMasterCompany;
        private readonly AppSettings _appSettings;

        public UserController(IServiceMasterUser serviceMasterUser, IServiceProvider serviceProvider,
            IOptions<SmtpSettings> smtpSettings, ILogger<BaseController> logger, IServiceUser serviceUser,
            IServiceInformation serviceInformation,
            IServiceMsgNotification serviceMsgNotification, IServiceMasterCompany serviceMasterCompany, IOptions<AppSettings> appSettings) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceInformation = serviceInformation;
            _serviceUser = serviceUser;
            _serviceMsgNotification = serviceMsgNotification;
            _smtpSettings = smtpSettings.Value;
            _serviceMasterUser = serviceMasterUser;
            _serviceMasterCompany = serviceMasterCompany;
            _appSettings = appSettings.Value;
        }

        [HttpPost("updatePwd"), Authorize("UPDATE_USER")]
        public ResponseData UpdatePwd([FromBody] dynamic objectToSave)
        {
            bool hasPermission = SpecificAuthorizationCheck.CheckAuthorizationByName(Constants.PASSWORD_SETTINGS, Request.HttpContext);

            _serviceMasterUser.UpdatePassword(objectToSave, hasPermission);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = new CreatedDataViewModel { EntityName = "USER" },
                flag = 1
            };
            return result;
           
        }
        [HttpPost("updatePicture"), Authorize("UPDATE")]
        public ResponseData UpdatePicture([FromBody] FileInfoViewModel fileInfo)
        {
            _serviceUser.UpdatePicture(fileInfo);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = new CreatedDataViewModel { EntityName = "USER" },
                flag = 1
            };
            return result;
        }
        [HttpPost("removePicture"), Authorize("UPDATE")]
        public ResponseData RemovePicture([FromBody] int idUser)
        {
            _serviceUser.RemovePicture(idUser);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = new CreatedDataViewModel { EntityName = "USER" },
                flag = 1
            };
            return result;
        }

        [HttpGet("getProfile/{id}"), Authorize("LIST_USER")]
        public ResponseData GetProfile(int id)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _serviceUser.GetProfile(id, userMail);
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            return result;
        }

        [HttpPost("getPredicate"), Authorize("LIST_USER")]
        public override ResponseData GetPredicate([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result;
            result = base.GetPredicate(model);
            if (result.listObject != null && result.listObject.listData != null && ((dynamic)result.listObject.listData).GetType().GetProperty("Count").GetValue(result.listObject.listData) > 0)
            {
                result.objectData = ((dynamic)result.listObject.listData)[0];
                //if (result.objectData.UserRole != null && result.objectData.UserRole.Count > 0)
                //{
                //    List<UserRoleViewModel> userRole = (List<UserRoleViewModel>)result.objectData.UserRole;

                //    result.objectData.UserRole = userRole.Where(c => !c.IsDeleted).ToList();
                //}
            }
            return result;
        }

        /// <summary>
        /// Gets list of users
        /// </summary>
        /// <param name="model">The model: a json format that contains the where predicate,
        /// orderBy predicate and the getWithRelations predicate</param>
        /// <returns>
        /// ResponseData format that contains a message If an error occurs
        /// or the specific data if it's a successful process
        /// </returns>
        [HttpPost("getListUsers"), Authorize("LIST_USER")]
        public virtual ResponseData getListUsers([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = _serviceUser.getListUsers(model)
                },
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }


        [HttpPost("getTargetedUsers")]
        public virtual ResponseData GetTargetedUsers([FromBody] TargetUserViewModel targetUserViewModel)
        {
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = _serviceInformation.GetTargetedUsers(targetUserViewModel)
                },
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        [HttpPost("getDataSourcePredicateUser"), Authorize("LIST_USER")]
        public virtual ResponseData GetDataSourcePredicateUser([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            var dataSourceResult = _serviceUser.GetListUser(model, userMail);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpPost("getUsersListWithRole"), Authorize("LIST_USER,UPDATE_INVENTORY_MOVEMENT,ADD_INVENTORY_MOVEMENT,SHOW_INVENTORY_MOVEMENT")]
        public virtual async Task<ResponseData> GetUsersListWithRole([FromBody] List<string> permissions)
        {
            AppHttpContext.Current.Request.Headers.TryGetValue("Authorization", out StringValues authorizationValue);
            string authorization = authorizationValue.First();
            using (HttpClient httpClient = new HttpClient())
            {
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                httpClient.DefaultRequestHeaders.Add("Origin", _appSettings.BaseUrl.ToString());
                httpClient.DefaultRequestHeaders.Add("Authorization", authorization);
                HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                {
                    RequestUri = new Uri(_appSettings.UsersByRoles + "companyCode=" + _serviceUser.GetCurrentCompany().Code, UriKind.Absolute),
                    Method = HttpMethod.Post,
                    Content = new StringContent(JsonConvert.SerializeObject(permissions), Encoding.UTF8, _appSettings.MasterMediaType)
                };
                HttpResponseMessage response = await httpClient.SendAsync(httpRequestMessage).ConfigureAwait(continueOnCapturedContext: false);
                object responseData = JsonConvert.DeserializeObject<IList<string>>(response.Content.ReadAsStringAsync().Result);

                ResponseData result = new ResponseData();
                //    GetUserMail();
                var dataSourceResult = _serviceUser.GetListUserWithRole((List<string>)responseData);
                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
                return result;
            }
            }

        [HttpPost("getListOfUsersParent"), Authorize("LIST_USER,ADD_PURCHASE_REQUEST,UPDATE_PURCHASE_REQUEST,SHOW_PURCHASE_REQUEST")]
        public virtual ResponseData GetListOfUsersParent([FromBody] UserViewModel objectToSend)
        {
            List<UserViewModel> users = new List<UserViewModel>();
            _serviceUser.GetListOfUsersParent(objectToSend.Id, users, objectToSend.Email);
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = users
                },
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }


        [HttpPatch("patch/{id}")]
        [AllowAnonymous]
        public void PartialUpdate(int id, [FromBody] JsonPatchDocument patches)
        {
            UserViewModel data = _serviceUser.GetModelAsNoTracked(u => u.Id == id);
            patches.ApplyTo(data);
            _serviceUser.patchModel(data);
        }

        [HttpPost("prepareAndSendEmail"), Authorize("UPDATE_USER"), Authorize("ADD_USER")]
        public void PrepareAndSendEmail([FromBody] ObjectToSaveViewModel data)
        {
            UserViewModel newUser = new UserViewModel();
            if (data.model.newUser != null)
            {
                newUser = JsonConvert.DeserializeObject<UserViewModel>(data.model.newUser.ToString());
            }
            string password = data.model.password.ToString();
            GetUserMail();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            // send Mail to the new user 
            _service.PrepareAndSendMailToTheNewUser(userMail, newUser, password, _smtpSettings);
            // send notif to the connected user to inform him that the mail was sent 
            _serviceUser.SendNotifToTheConnectedUserAfterAddingNewUserAccount(userMail, newUser);

        }

        [HttpPost("updateB2BUser"), Authorize("UPDATE_USER")]
        public virtual ResponseData UpdateB2BUser([FromBody] UserViewModel userB2b)
        {
            var obj = _serviceUser.UpdateB2BUser(userB2b);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = obj
            };
            return result;
        }
        [HttpPost("signOut"), Authorize("UPDATE_USER")]
        public virtual ResponseData signOut([FromBody] string email)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = _serviceUser.signOut(email)
            };
            return result;
        }

        [HttpPost("getUsersListFromMasterBase"), Authorize("LIST_GROUPUSERS")]
        public DataSourceResult<MasterUserViewModel> GetMasterUsersList([FromBody] dynamic objectToSave)
        {
            GetUserMail();
            userMail = char.ToLowerInvariant(userMail[0]) + userMail.Substring(1);
            return _serviceUser.GetMasterUsers(objectToSave, userMail);
        }

        /// <summary>
        /// InsertUserInThisCompany
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("insertUserInThisCompany"), Authorize("ADD_USER")]
        public ResponseData InsertUserInThisCompany([FromBody] UserViewModel model)
        {
            return new ResponseData
            {
                objectData = _serviceUser.InsertUserInThisCompany(model, null, null),
                customStatusCode = CustomStatusCode.AddSuccessfull,
                flag = 1
            };
        }

        [HttpPost("deleteUserFromSlaveBase"), Authorize("DELETE_USER")]
        public ResponseData DeleteUserFromSlaveBase([FromBody] string userMail)
        {
            return new ResponseData
            {
                objectData = _serviceUser.DeleteUserFromSlaveBase(userMail),
                customStatusCode = CustomStatusCode.DeleteSuccessfull,
                flag = 1
            };
        }

        [HttpPost("synchronizeWithMaster"), Authorize("LIST_USER")]
        public ResponseData SynchronizeWithMaster()
        {
            return new ResponseData
            {
                objectData = _serviceUser.SynchronizeWithMaster(),
                flag = 1
            };
        }

        [HttpPost, DisableRequestSizeLimit, Route("importFileUsers"), Authorize("IMPORT_USER")]
        public ResponseData UploadFilesAsync([FromBody] FileInfoViewModel model)
        {
            var excelDataByteArray = Convert.FromBase64String(model.FileData);
            // When creating a stream, you need to reset the position, without it you will see that you always write files with a 0 byte length.
            using (MemoryStream excelDataStream = new MemoryStream(excelDataByteArray))
            {
                ResponseData result = new ResponseData
                {
                    listObject = new ListObject
                    {
                        listData = _serviceUser.GenerateUsersListFromExcel(excelDataStream)
                    },
                    customStatusCode = CustomStatusCode.GetSuccessfull
                };
                return result;
            }
        }

        [HttpPost, Route("insertUsersList"), Authorize("IMPORT_USER")]
        public ResponseData InsertUsersList([FromBody] IList<UserViewModel> userList)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                _serviceUser.AddOrUpdateUserFromExcel(userList, userMail, _smtpSettings);
                result.customStatusCode = CustomStatusCode.DocumentImportedSuccessfully;
                result.flag = NumberConstant.One;
                return result;
            }
        }

        [HttpPost("ChangeStateOfUser")]
        public ResponseData ChangeActifStateOfUser([FromBody] int userId)
        {
            dynamic obj = _serviceUser.ChangeStateOfUser(userId);
            CustomStatusCode customStatusCode = obj.IsActif ? CustomStatusCode.EnableUserSuccessfull : CustomStatusCode.DisableUserSuccessfull;
            ResponseData result = new ResponseData
            {
                customStatusCode = customStatusCode,
                flag = NumberConstant.One,
                objectData = obj.obj
            };
            return result;
        }


        /// <summary>
        /// get users from list of Id 
        /// </summary>
        /// <param name="listIdUsers"></param>
        /// <returns></returns>
        [HttpPost("getUsersFromListId")]
        public List<UserViewModel> GetUsersFromListId([FromBody] List<int> listIdUsers)
        {

            return _serviceUser.GetUsersFromListId(listIdUsers);
        }

        /// <summary>
        /// desactivate massive users from list of users
        /// </summary>
        /// <param name="listOfUsers"></param>        
        [HttpPost("desactivateMassiveUsers"), Authorize("UPDATE_USER")]
        public ResponseData DesactivateMassiveUsers([FromBody] List<UserViewModel> listOfUsers)
        {
            var obj = _serviceUser.DesactivateMassiveUsers(listOfUsers);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.DisableMassifUsersSuccessfull,
                objectData = obj,
                flag = NumberConstant.One
            };
            return result;
        }

        /// <summary>
        /// reactivate massive users from list of users
        /// </summary>
        /// <param name="listOfUsers"></param>        
        [HttpPost("reactivateMassiveUsers"), Authorize("UPDATE_USER")]
        public ResponseData ReactivateMassiveUsers([FromBody] List<UserViewModel> listOfUsers)
        {
            var obj = _serviceUser.ReactivateMassiveUsers(listOfUsers);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.EnableMassifUsersSuccessfull,
                flag = NumberConstant.One,
                objectData = obj
            };
            return result;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_USER,SHOW_COMPANY,UPDATE_COMPANY,COMPANY,ADD_ACTION,EDIT_ACTION,OWN_ACTION,ADD_CONTACT,OWN_CONTACT,EDIT_CONTACT,OWN_ORGANISATION,EDIT_ORGANISATION,EDIT_OPPORTUNITY,OWN_OPPORTUNITY,SHOW_WAREHOUSE,UPDATE_WAREHOUSE,ADD_ZONE,ADD_WAREHOUSE,UPDATE_ZONE,ADD_SHELF_STORAGE,UPDATE_SHELF_STORAGE," +
            "LIST_CASH_MANAGEMENT")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            var dataSourceResult = _serviceUser.GetListUser(model, userMail);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }
        [HttpGet("getUserPhoneById/{id}"), Authorize("UPDATE_USER"), Authorize("SHOW_USER")]
        public PhoneViewModel getUserPhoneById(int id)
        {
            return _serviceUser.GetModelAsNoTracked(x => x.Id == id, x => x.IdPhoneNavigation).IdPhoneNavigation;
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_WAREHOUSE,SHOW_INVENTORY_MOVEMENT,ADD_INVENTORY_MOVEMENT,UPDATE_INVENTORY_MOVEMENT")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }

        [HttpPost("getByEmail")]
        public virtual ResponseData GetByEmail([FromBody] string email)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.flag = 1;
                result.objectData = _service.GetModelByEmail(email);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }
        [HttpPost("getModelByCondition"), Authorize("VIEW_ACTION "), Authorize("VIEW_LEAVE"), Authorize("SHOW_USER")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }

        [HttpPost("getUserIdByEmail")]
        public ResponseData GetUserIdByEmail([FromBody] string email)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.flag = 1;
                result.objectData = _serviceUser.GetUserIdByEmail(email);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }

        [HttpPost("getPictures"), Authorize("LIST_USER")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }
        [HttpPut("updateProfile")]
        public ResponseData UpdateProfile(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }

        /// <summary>
        /// change user language
        /// </summary>
        /// <param name="listOfUsers"></param>        
        [HttpPost("ChangeUserLanguage"), Authorize("UPDATE_USER")]
        public ResponseData ChangeUserLanguage([FromBody] string lang)
        {
            GetUserMail();
            var obj = _serviceUser.ChangeUserLanguage(userMail, lang);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.EnableMassifUsersSuccessfull,
                flag = NumberConstant.One,
                objectData = obj
            };
            return result;
        }

    }
}
