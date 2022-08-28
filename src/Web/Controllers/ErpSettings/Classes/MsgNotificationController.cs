using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.ErpSettings.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using Web.Controllers.ErpSettings.Interfaces;
using Web.Controllers.GenericController;

namespace Web.Controllers.ErpSettings.Classes
{
    [Route("api/msgnotification")]
    public class MsgNotificationController : BaseController, IMsgNotificationController
    //, IMsgNotificationController
    {

        private readonly IServiceMsgNotification _msgNotificationService;
        public MsgNotificationController(IServiceMsgNotification msgNotificationService, IServiceProvider serviceProvider, ILogger<MailingController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _msgNotificationService = msgNotificationService;
        }

        [HttpPost("drop"), Authorize("DELETE")]
        public ResponseData DropNotification([FromBody]dynamic model)
        {
            ResponseData result = new ResponseData();
            NotificationItemViewModel notificationItemViewModel = JsonConvert.DeserializeObject(model.Model.ToString(), type: typeof(NotificationItemViewModel));
            _msgNotificationService.DropNotification(notificationItemViewModel.IdNotification, notificationItemViewModel.IdTargetUser);
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }


        [HttpPost("markNotificationAsRead"), Authorize("UPDATE")]
        public ResponseData MarkNotificationAsRead([FromBody]dynamic paramsObject)
        {
            ResponseData result = new ResponseData();
            NotificationItemViewModel notificationItemViewModel = JsonConvert.DeserializeObject(paramsObject.Model.ToString(), type: typeof(NotificationItemViewModel));
            _msgNotificationService.MarkNotificationAsRead(notificationItemViewModel.IdNotification, notificationItemViewModel.IdTargetUser);
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }
        [HttpPost("markAllAsRead"), Authorize("UPDATE")]
        public ResponseData MarkAllAsRead([FromBody]dynamic paramsObject)
        {
            ResponseData result = new ResponseData();
            NotificationItemViewModel notificationItemViewModel = JsonConvert.DeserializeObject(paramsObject.Model.ToString(), type: typeof(NotificationItemViewModel));
            _msgNotificationService.MarkAllAsRead(notificationItemViewModel.IdTargetUser);
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }
        [HttpPost("getNotificationsWithPagination")]
        public ResponseData ListNotificationWithPagination([FromBody]dynamic paramsObject)
        {
            ResponseData result = new ResponseData();
            string userMail = paramsObject["Model"].userMail;
            int pageNumber = paramsObject.Model.pageNumber;
            int pageSize = paramsObject.Model.pageSize;

            List<NotificationItemViewModel> notifications = _msgNotificationService.ListNotificationWithPagination(userMail, pageNumber, pageSize);

            result.listObject = new ListObject
            {
                listData = notifications
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpPost("getUnreadNotificationCount")]
        public ResponseData GetUnreadNotificationCount([FromBody]dynamic paramsObject)
        {
            ResponseData result = new ResponseData();
            string userMail = paramsObject.Model.userMail;
            int pageNumber = paramsObject.Model.pageNumber;
            int pageSize = paramsObject.Model.pageSize;

            int notifications = _msgNotificationService.ListNotificationcount(userMail);

            result.listObject = new ListObject
            {
                listData = notifications
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }
        [HttpPost("notifyUsersFromLeave")]
        public ResponseData notifyUsers([FromBody] DataToSendForNotificationViewModel notificationData)
        {
            ResponseData result = new ResponseData();
            _msgNotificationService.PrepareAndNotifyUser(notificationData.InformationType,
                notificationData.IdEntityReference, notificationData.CodeEntity, notificationData.TypeMessage,
                notificationData.UserMail, notificationData.SpecificData, notificationData.UsersIds, notificationData.CompanyCode);
            return result;
        }
    }
}
