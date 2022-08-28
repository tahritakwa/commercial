using Microsoft.AspNetCore.SignalR;
using Newtonsoft.Json;
using Services.Specific.ErpSettings.Interfaces;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ViewModels.DTO.Common;

namespace Services.Specific.Hubs
{
    public class CommentHub : BaseHub
    {
        private static IServiceComment _serviceComment;


        public CommentHub(IServiceComment serviceComment)
        {
            _serviceComment = serviceComment;
        }


        /// <summary>
        /// Override OnConnectedAsync
        /// </summary>
        /// <returns></returns>
        public override Task OnConnectedAsync()
        {
            var httpContect = GetHttpContext();

            var user = new UserDetail
            {
                ConnectionId = Context.ConnectionId,
                UserMail = httpContect.Request.Query["userMail"]
            };
            ConnectedUsers.Add(user);
            //cette requete permet de récuperer la liste des connectionsIds et de chercher les emails a notifier et connecté en meme temps
            if (user.ConnectionId != null)
            {
                return Clients.Client(user.ConnectionId).SendAsync("OnConnectedAsync");
            }
            return base.OnConnectedAsync();
        }

        /// <summary>
        /// Send comment to client
        /// </summary>
        /// <param name="dynamicObj"></param>
        /// <returns></returns>
        public Task SendComment(string dynamicObj)
        {
            var sendedObject = JsonConvert.DeserializeObject<SendedObject>(dynamicObj);
            //cette requete permet de récuperer la liste des connectionsIds et de chercher les emails a notifier et connecté en meme temps
            var connectionIds = (IReadOnlyList<string>)ConnectedUsers.Where(x => !sendedObject.Mails.Contains(x.UserMail)).Select(x => x.ConnectionId).ToList();

            var commentToSend = _serviceComment.GetComments(sendedObject.EntityName, sendedObject.IdEntityCreated).LastOrDefault();
            if (connectionIds.Any())
            {
                return Clients.AllExcept(connectionIds).SendAsync("SendComment", JsonConvert.SerializeObject(commentToSend));
            }
            else
            {
                return Clients.All.SendAsync("SendComment", JsonConvert.SerializeObject(commentToSend));
            }
        }
    }
}

