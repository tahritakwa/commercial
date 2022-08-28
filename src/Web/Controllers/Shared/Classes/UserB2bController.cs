using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Linq;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Comparers;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Utils;
using Web.Controllers.GenericController;
using Web.Controllers.Shared.Interfaces;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/UserB2b")]

    public class UserB2bController : BaseController, IUserB2bController
    {
        private readonly IServiceInformation _serviceInformation;
        private readonly IServiceUser _serviceUser;
        private readonly IServiceCompany _serviceCompany;
        public UserB2bController(IServiceProvider serviceProvider,
            ILogger<BaseController> logger,
            IServiceInformation serviceInformation,
            IServiceUser serviceUser, IServiceCompany serviceCompany) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceInformation = serviceInformation;
            _serviceUser = serviceUser;
            _serviceCompany = serviceCompany;
        }

        [HttpGet("getUserIdFromIdTiers/{idTiers}"), Authorize(Roles = "SHOW")]
        public ResponseData GetUserIdFromIdTiers(int idTiers)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            var userB2b = _serviceUser.FindModelBy(x => x.IdTiers == idTiers).FirstOrDefault();
            if (userB2b != null)
            {
                result.objectData = userB2b.Id;
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
                result.flag = 1;
            }
            else
            {
                result.customStatusCode = CustomStatusCode.NotFound;
            }
            return result;
        }
        [HttpPost("getTargetedUsers"), AllowAnonymous]
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
        [HttpPost("disconnectUser"), AllowAnonymous]
        public virtual ResponseData DisconnectUser([FromBody] string userMail)
        {
            _serviceUser.signOut(userMail);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }
       
    }
}
