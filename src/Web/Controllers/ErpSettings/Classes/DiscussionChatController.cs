using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Shared;
using Web.Controllers.GenericController;

// For more information on enabling Web API for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace Web.Controllers.ErpSettings.Classes
{
    [Route("api/discussionChat")]
    public class DiscussionChatController : BaseController
    {
        private readonly IServiceDiscussionChat _serviceDiscussionChat;
        private readonly IServiceUserDiscussionChat _serviceUserDiscussionChat;
        private readonly IServiceUser _serviceUser;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        /// <param name="serviceDiscussionChat"></param>
        /// <param name="serviceUser"></param>
        /// <param name="serviceUserDiscussionChat"></param>
        public DiscussionChatController(IServiceDiscussionChat serviceDiscussionChat, IServiceUser serviceUser, IServiceUserDiscussionChat serviceUserDiscussionChat, IServiceProvider serviceProvider)
            : base(serviceProvider, null)
        {
            _serviceProvider = serviceProvider;
            _serviceDiscussionChat = serviceDiscussionChat;
            _serviceUserDiscussionChat = serviceUserDiscussionChat;
            _serviceUser = serviceUser;
        }

        /// <summary>
        /// This method is call if select a discussion chat
        /// </summary>
        /// <param name="idReceiver"></param>
        /// <returns></returns>
        [HttpGet("getDiscussionChat/{idReceiver}"), AllowAnonymous]
        public dynamic GetDiscussionChat(int idReceiver)
        {
            DiscussionViewModel discussion;

            GetUserMail();
            UserViewModel currentUser = _serviceUser.GetModel(user => user.Email == userMail);
            UserViewModel receiverUser = _serviceUser.GetModel(user => user.Id == idReceiver);
            ResponseData result;
            // Get pair discussion
            discussion = _serviceDiscussionChat.GetDiscussion(currentUser.Id, receiverUser.Id);
            result = new ResponseData
            {
                flag = 1,
                objectData = discussion,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// This method is call if select a discussion chat
        /// </summary>
        /// <param name="idDiscussion"></param>
        /// <returns></returns>
        [HttpGet("getDiscussionChatById/{idDiscussion}"), AllowAnonymous]
        public dynamic GetDiscussionChatById(int idDiscussion)
        {
            GetUserMail();

            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDiscussionChat.GetDiscussionById(idDiscussion, userMail),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// This method is call if select a discussion chat
        /// </summary>
        /// <param name="idReceiver"></param>
        /// <returns></returns>
        [HttpGet("createDiscussionChat/{idReceiver}"), AllowAnonymous]
        public dynamic CreateDiscussionChat(int idReceiver)
        {
            DiscussionViewModel discussion;

            GetUserMail();
            UserViewModel currentUser = _serviceUser.GetModel(user => user.Email == userMail);
            UserViewModel receiverUser = _serviceUser.GetModel(user => user.Id == idReceiver);
            ResponseData result;

            // create discussion 
            discussion = _serviceDiscussionChat.AddDiscussion(currentUser, receiverUser);
            _serviceUserDiscussionChat.AddUserDiscussion(discussion.Id, currentUser.Id, receiverUser.Id);
            discussion = _serviceDiscussionChat.GetDiscussion(currentUser.Id, receiverUser.Id);
            result = new ResponseData
            {
                flag = 1,
                objectData = discussion,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        /// <summary>
        /// This method is call to add a user to group of discussion chat
        /// </summary>
        /// <returns></returns>
        [HttpPost("addNewMembers"), AllowAnonymous]
        public dynamic AddNewMembers([FromBody] ObjectToSaveViewModel objectToSave)
        {
            GetUserMail();

            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDiscussionChat.AddNewMembers(objectToSave, userMail),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// This method is call to create  group of discussion chat
        /// </summary>
        /// <returns></returns>
        [HttpPost("createChatGroup"), AllowAnonymous]
        public dynamic CreateChatGroup([FromBody] ObjectToSaveViewModel objectToSave)
        {
            GetUserMail();

            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDiscussionChat.CreateChatGroup(objectToSave, userMail),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        /// <summary>
        /// This method is call to update the name of group discussion
        /// </summary>
        /// <returns></returns>
        [HttpPost("updateChatGroupName"), AllowAnonymous]
        public dynamic UpdateChatGroupName([FromBody] ObjectToSaveViewModel objectToSave)
        {
            GetUserMail();

            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDiscussionChat.UpdateChatGroupName(objectToSave, userMail),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        /// <summary>
        /// This method is call too get list discussion of current user
        /// </summary>
        /// <returns></returns>
        [HttpGet("getListDiscussionsOfCurrentUser"), AllowAnonymous]
        public dynamic GetListDiscussionsOfCurrentUser()
        {
            List<DiscussionViewModel> myDiscussions = new List<DiscussionViewModel>();

            GetUserMail();
            UserViewModel currentUser = _serviceUser.GetModel(user => user.Email == userMail);
            ResponseData result;
            if (currentUser != null)
            {
                myDiscussions = _serviceDiscussionChat.GetListDiscussionsOfCurrentUser(currentUser.Id);
            }


            result = new ResponseData
            {
                flag = 1,
                objectData = myDiscussions,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        /// <summary>
        /// This method is call too get number of notifications
        /// </summary>
        /// <returns></returns>
        [HttpGet("getNumberOfNotifChat"), AllowAnonymous]
        public dynamic GetNumberOfNotifChat()
        {
            GetUserMail();

            int numberOfNotif = 0;
            ResponseData result;
            UserViewModel currentUser = _serviceUser.GetModel(user => user.Email == userMail);
            //Get number of notification of current user
            numberOfNotif = _serviceUserDiscussionChat.GetModelsWithConditionsRelations(x => x.IdUser == currentUser.Id && x.HasNotif == true).Count();
            result = new ResponseData
            {
                flag = 1,
                objectData = numberOfNotif,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// This method is call too get list  messages of a discussion
        /// </summary>
        /// <param name="paramsObject"></param>
        /// <returns></returns>
        [HttpPost("getDiscussionMessagesChat"), AllowAnonymous]
        public dynamic GetDiscussionMessagesChat([FromBody]dynamic paramsObject)
        {
            int idDiscussion = paramsObject.Model.idDiscussion;
            int pageNumber = paramsObject.Model.pageNumber;
            int pageSize = paramsObject.Model.pageSize;
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDiscussionChat.GetDiscussionMessagesChat(idDiscussion, pageNumber, pageSize),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// This method is call when user send a message
        /// </summary>
        /// <param name="message"></param>
        /// <returns></returns>
        [HttpPost("addMessage"), AllowAnonymous]
        public dynamic AddMessage([FromBody] MessageChatViewModel message)
        {
            GetUserMail();
            // Notif receiver  user 
            _serviceDiscussionChat.NotifUserDiscussion(message, userMail);
            ResponseData result;
            result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDiscussionChat.AddMessage(message),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// This method is call when user send a message and notif reciever user
        /// </summary>
        /// <param name="userDiscussionChat"></param>
        /// <returns></returns>
        [HttpPost("markNotifUserDiscussion"), AllowAnonymous]
        public dynamic MarkNotifUserDiscussion([FromBody] UserDiscussionChatViewModel userDiscussionChat)
        {
            GetUserMail();
            // Mark user discussion as viewed
            _serviceDiscussionChat.MarkNotifUserDiscussion(userDiscussionChat, userMail);
            ResponseData result;
            result = new ResponseData
            {
                flag = 1,
                objectData = null,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
    }
}

