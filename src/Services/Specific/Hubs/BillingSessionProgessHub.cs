using Microsoft.AspNetCore.SignalR;
using Newtonsoft.Json;
using Persistence;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ViewModels.DTO.Common;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Sales;

namespace Services.Specific.Hubs
{
    public class BillingSessionProgessHub : BaseHub
    {
        private static ProgressBar _progress;

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
            return Clients.All.SendAsync("OnConnectedAsync");
        }

        /// <summary>
        /// Send ProgressBar progression to all client
        /// </summary>
        /// <param name="IdSession"></param>
        /// <param name="max"></param>
        /// <param name="progressHubContext"></param>
        /// <param name="documentViewModel"></param>
        /// <returns></returns>
        public static Task SendProgress(int idSession, int max, IHubContext<BillingSessionProgessHub> progressHubContext, DocumentViewModel documentViewModel)
        {
            if (progressHubContext == null)
            {
                return Task.Delay(0);
            }
            // Create new instance of progress if it not exist
            if (_progress == null)
            {
                _progress = new ProgressBar(idSession, max);
            }
            _progress.State = ProgressBarState.Pending;
            _progress.Treated++;
            _progress.Progression = Math.Floor(_progress.Treated * 100 / (float)_progress.MaximalValue);
            if (documentViewModel != null)
            {
                _progress.SuccesseFullyGeneratedObjects.Add(documentViewModel);
            }
            else
            {
                _progress.WrongGeneratedObjects.Add(documentViewModel);
            }
            if (_progress.Treated == max)
            {
                _progress.State = ProgressBarState.Completed;
            }
            // BillingSessionProgression is configured in StartUp.cs (in Configure method)
            var connectionIds = (IReadOnlyList<string>)ConnectedUsers.Where(x => x != null && x.UserMail != ActiveAccountHelper.GetConnectedUserEmail()).Select(x => x.ConnectionId).ToList();
            return progressHubContext.Clients.AllExcept(connectionIds).SendAsync("BillingSessionProgression", JsonConvert.SerializeObject(_progress));
        }

        /// <summary>
        /// Clear progress 
        /// </summary>
        /// <param name="IdSession"></param>
        /// <param name="progressHubContext"></param>
        /// <returns></returns>
        public static Task ClearProgress(IHubContext<BillingSessionProgessHub> progressHubContext)
        {
            if (progressHubContext == null)
            {
                return Task.Delay(0);
            }
            _progress = null;
            var connectionIds = (IReadOnlyList<string>)ConnectedUsers.Where(x => x != null && x.UserMail != ActiveAccountHelper.GetConnectedUserEmail()).Select(x => x.ConnectionId).ToList();
            return progressHubContext.Clients.AllExcept(connectionIds).SendAsync("BillingSessionProgression");
        }
    }
}
