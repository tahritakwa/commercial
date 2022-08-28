using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.SignalR;
using Newtonsoft.Json;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Constants;
using ViewModels.DTO.Common;
using ViewModels.DTO.Shared;

namespace Services.Specific.Hubs
{
    public class ChatHub : Hub
    {
        private static IServiceUser _serviceUser;


        #region Data Members
        protected static List<UserDetailChatDiscussion> ConnectedUsers { get; set; }
        protected static List<UserDetailChatDiscussion> UnConnectedUsers { get; set; }
        #endregion

        public ChatHub(IServiceUser serviceUser)
        {
            if (ConnectedUsers == null)
            {
                ConnectedUsers = new List<UserDetailChatDiscussion>();
            }
            _serviceUser = serviceUser;
        }
        protected HttpContext GetHttpContext()
        {
            return Context.GetHttpContext();
        }
        /// <summary>
        /// Action created to add any user connected in list of connnected users
        /// </summary>
        /// <returns></returns>
        public override Task OnConnectedAsync()
        {
            var httpContext = GetHttpContext();
            var mail = httpContext.Request.Query[Constants.USER_MAIL];

            UserDetailChatDiscussion userDetail = ConnectedUsers.Find(x => x.UserMail == mail);
            if (userDetail == null)
            {
                userDetail = new UserDetailChatDiscussion
                {
                    UserMail = mail,
                    ConnectionIds = new List<String>()

                };

                UserViewModel data = _serviceUser.GetModelAsNoTracked(u => u.Email == userDetail.UserMail);

                userDetail.UserPicture = data.Picture;
                userDetail.FullName = data.FirstName + " " + data.LastName;
                userDetail.Id = data.Id;
                data.IsUserOnline = true;
                ConnectedUsers.Add(userDetail);


            }
            if (!userDetail.ConnectionIds.Exists(x => x == Context.ConnectionId))
            {
                userDetail.ConnectionIds.Add(Context.ConnectionId);
            }
            List<UserViewModel> listUsers = _serviceUser.GetAllModels().ToList();
            List<UserDetailChatDiscussion> listUsersDetails = new List<UserDetailChatDiscussion>();

            /* Build */
            foreach (UserViewModel user in listUsers)
            {
                UserDetailChatDiscussion userDetail1 = new UserDetailChatDiscussion
                {
                    UserMail = user.Email,
                    ConnectionIds = new List<String>(),
                    UserPicture = user.Picture,
                    FullName = user.FirstName + " " + user.LastName,
                    Id = user.Id,
                };
                listUsersDetails.Add(userDetail1);

            }
            UnConnectedUsers = listUsersDetails.Where(f => !ConnectedUsers.Any(t => t.Id == f.Id)).ToList();

            Clients.All.SendAsync(Constants.LIST_UNCONNECTED_USER, JsonConvert.SerializeObject(UnConnectedUsers));
            Clients.All.SendAsync(Constants.LIST_CONNECTED_USER, JsonConvert.SerializeObject(ConnectedUsers));
            return base.OnConnectedAsync();
        }
        /// <summary>
        /// Action created to delete user disconnected from application
        /// </summary>
        /// <param name="exception"></param>
        /// <returns></returns>
        public override Task OnDisconnectedAsync(Exception exception)
        {
            try
            {

                UserDetailChatDiscussion userToDelete = ConnectedUsers.Find(x => x.ConnectionIds.Contains(Context.ConnectionId));
                UserViewModel data = _serviceUser.GetModelAsNoTracked(u => u.Email == userToDelete.UserMail);
                data.IsUserOnline = false;
                if (userToDelete != null)
                {
                    userToDelete.ConnectionIds.Remove(Context.ConnectionId);
                    if (userToDelete.ConnectionIds.Count() == 0)
                        ConnectedUsers.Remove(userToDelete);

                    UnConnectedUsers.Add(userToDelete);
                }
                Clients.All.SendAsync(Constants.LIST_UNCONNECTED_USER, JsonConvert.SerializeObject(UnConnectedUsers));
                Clients.All.SendAsync(Constants.LIST_CONNECTED_USER, JsonConvert.SerializeObject(ConnectedUsers));

            }
            catch (ArgumentOutOfRangeException)
            {
                return Task.Delay(0);
            }
            return base.OnDisconnectedAsync(exception);
        }


        
        /// <summary>
        /// Used to send data to connected users into list users geted in input parameters
        /// </summary>
        /// <param name="dynamicObj"></param>
        /// <returns></returns>
        public Task SendSomeDataToConnectedUsers(string dynamicObj)
        {
            ChatDataDetails sendedObject = JsonConvert.DeserializeObject<ChatDataDetails>(dynamicObj);
            IList<int> idUserReceiver = sendedObject.userDiscussions.Select(x => x.IdUser).ToList();
            List<UserDetailChatDiscussion> receiverUsers = ConnectedUsers.Where(x => idUserReceiver.Contains(x.Id)).ToList();
            List<string> connectionsIds = new List<String>();
            foreach (UserDetailChatDiscussion userDetailChatDiscussion in receiverUsers)
            {

                connectionsIds.AddRange(userDetailChatDiscussion.ConnectionIds);

            }

            if (sendedObject.message != null)
            {
                return Clients.Clients(connectionsIds).SendAsync(Constants.RECEIVE_MESSAGE, JsonConvert.SerializeObject(sendedObject.message));
            }
            else if (sendedObject.userSeenLastMessage != null)
            {
                return Clients.Clients(connectionsIds).SendAsync(Constants.RECEIVE_SEEN_MESSAGE_EVENT, JsonConvert.SerializeObject(sendedObject.userSeenLastMessage));
            }
            else if (sendedObject.newName != null)
            {
                return Clients.Clients(connectionsIds).SendAsync(Constants.RECEIVE_NEW_DISCUSSION_NAME , JsonConvert.SerializeObject(sendedObject));
            }
            else
            {
                return Clients.Clients(connectionsIds).SendAsync(Constants.RECEIVE_NEW_GROUP_MEMBERS, JsonConvert.SerializeObject(sendedObject));
            }
        }


    }
}
