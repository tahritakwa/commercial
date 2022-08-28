using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Shared.Interfaces;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.ErpSettings.Interfaces;
using Web.Controllers.GenericController;

namespace Web.Controllers.ErpSettings.Classes
{
    [Route("api/notification")]
    public class NotificationController : BaseController, INotificationController
    {
        private readonly IServiceMessage _msgService;
        private readonly IServiceUser _userService;
        /// <summary>
        /// Notification controller
        /// </summary>
        /// <param name="userService"></param>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        public NotificationController(IServiceMessage msgService, IServiceUser userService, IServiceProvider serviceProvider, ILogger<MailingController> logger)
              : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _msgService = msgService;
            _userService = userService;
        }
        /// <summary>
        /// Get list of mails and the message to send in notifications
        /// </summary>
        /// <param name="information"></param>
        /// <returns></returns>
        [HttpPost("getNotificationInput"), AllowAnonymous]
        public ResponseData GetNotificationInput([FromBody]dynamic model)
        {
            ResponseData result = new ResponseData();
            if (model != null)
            {
                GetUserMail();
                //get the user sended from generic factory service
                var user = _userService.GetModel(x => x.Email == userMail);
                MessageViewModel message = JsonConvert.DeserializeObject(model.Model.ToString(), type: typeof(MessageViewModel));
                message.IdCreator = user.Id;
                int idMsg = _msgService.AddMessage(message, null, user.Email);
                result.objectData = idMsg;
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
            }
            return result;
        }
    }
}
