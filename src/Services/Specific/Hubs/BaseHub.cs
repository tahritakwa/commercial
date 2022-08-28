using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.SignalR;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ViewModels.DTO.Common;

namespace Services.Specific.Hubs
{
    public class BaseHub : Hub
    {
        #region Data Members

        public static List<UserDetail> ConnectedUsers { get; set; }
        protected static List<MessageDetail> CurrentMessage { get; set; }
        #endregion

        public BaseHub()
        {
            if (ConnectedUsers == null)
            {
                ConnectedUsers = new List<UserDetail>();
            }
        }

        #region Methods
        /// <summary>
        /// Get the HTTP Context to get hedears and paramaters
        /// </summary>
        /// <returns></returns>
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
            try
            {
                var httpContext = GetHttpContext();
                var user = new UserDetail()
                {
                    ConnectionId = Context.ConnectionId,
                    UserMail = httpContext.Request.Query["userMail"]
                };
                if (!ConnectedUsers.Contains(user))
                {
                    ConnectedUsers.Add(user);
                }
                return base.OnConnectedAsync();
            }
            catch(Exception e)
            {
                throw e; 
            }
           
        }
        public List<UserDetail> GetConnectedUsers()
        {
            return ConnectedUsers;
        }
        /// <summary>
        /// Action created to delete user disconnected from application
        /// </summary>
        /// <param name="exception"></param>
        /// <returns></returns>
        public override Task OnDisconnectedAsync(Exception exception)
        {
            var httpContext = GetHttpContext();
            var user = new UserDetail()
            {
                ConnectionId = Context.ConnectionId,
                UserMail = httpContext.Request.Query["userMail"]
            };
            try
            {
                var userToDelete = ConnectedUsers.SingleOrDefault(x => x != null && x.ConnectionId == user.ConnectionId && x.UserMail == user.UserMail);
                if (userToDelete != null)
                    ConnectedUsers.Remove(userToDelete);
            }
            catch (ArgumentOutOfRangeException)
            {
                return Task.Delay(0);
            }
            return base.OnDisconnectedAsync(exception);
        }
        /// <summary>
        /// Used to send broadcast message 
        /// </summary>
        /// <param name="message"></param>
        /// <returns></returns>
        public async Task Send(string message)
        {
            if (message.Contains("<script>"))
            {
                throw new Exception("This message will flow to the client " + new { user = Context.User.Identity.Name, message = message });
            }
            await Clients.All.SendAsync("Send", new { Message = message });
        }
        /// <summary>
        /// Used to send broadcast message expect the sender
        /// </summary>
        /// <param name="message"></param>
        /// <returns></returns>
        public Task SendToAllExpectMe(string message)
        {
            return Clients.AllExcept(new List<string>
            {
                Context.ConnectionId
            })
            .SendAsync("SendToAllExpectMe", message);
        }
        /// <summary>
        /// Used to send message to list users geted in input parameters
        /// </summary>
        /// <param name="dynamicObj"></param>
        /// <returns></returns>
        public Task SendToSpecificUser(string dynamicObj)
        {
            if (dynamicObj.Contains("<script>"))
            {
                throw new Exception("This message will flow to the client " + new { user = Context.User.Identity.Name, message = dynamicObj });
            }
            var sendedObject = JsonConvert.DeserializeObject<SendedObject>(dynamicObj);
            var connectionIds = (IReadOnlyList<string>)ConnectedUsers.Where(x => x.UserMail != sendedObject.Mails.First()).Select(x => x.ConnectionId).ToList();
            if (connectionIds.Any())
                return Clients.AllExcept(connectionIds).SendAsync("SendToSpecificUser", sendedObject.Message);
            else
                throw new Exception("connectionIds not found");
        }
        /// <summary>
        /// Used to send message to list users geted in input parameters expect the sender
        /// </summary>
        /// <param name="dynamicObj"></param>
        /// <returns></returns>
        public virtual Task SendToMultipleUsers(string dynamicObj)
        {
            if (dynamicObj.Contains("<script>"))
            {
                throw new Exception("This message will flow to the client " + new { user = Context.User.Identity.Name, message = dynamicObj });
            }
            var sendedObject = JsonConvert.DeserializeObject<SendedObject>(dynamicObj);
            //cette requete permet de récuperer la liste des connectionsIds et de chercher les emails a notifier et connecté en meme temps
            var connectionIds = (IReadOnlyList<string>)ConnectedUsers.Where(x => !sendedObject.Mails.Contains(x.UserMail)).Select(x => x.ConnectionId).ToList();
            if (connectionIds.Any())
                return Clients.AllExcept(connectionIds).SendAsync("SendToMultipleUsers", sendedObject.Message);
            else
                return Clients.All.SendAsync("SendToMultipleUsers", sendedObject.Message);

        }

        #endregion

    }
}
