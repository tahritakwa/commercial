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

namespace Services.Specific.Hubs
{
    public class LeaveBalanceRemainingProgressHub : BaseHub
    {
        private static ProgressBar _progressMap;

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
        /// <param name="max"></param>
        /// <param name="progressHubContext"></param>
        /// <returns></returns>
        public static Task SendProgress(int max, IHubContext<LeaveBalanceRemainingProgressHub> progressHubContext)
        {
            if (progressHubContext == null)
            {
                return Task.Delay(0);
            }
            // Create new instance of progress
            if (_progressMap is null)
            {
                _progressMap = new ProgressBar
                {
                    MaximalValue = max
                };
            }
            _progressMap.State = ProgressBarState.Pending;
            _progressMap.Treated++;
            _progressMap.Progression = Math.Floor(_progressMap.Treated * 100 / (float)_progressMap.MaximalValue);
            if (_progressMap.Treated == max)
            {
                _progressMap.State = ProgressBarState.Completed;
            }
            var connectionIds = (IReadOnlyList<string>)ConnectedUsers.Where(x => x != null && x.UserMail != ActiveAccountHelper.GetConnectedUserEmail()).Select(x => x.ConnectionId).ToList();
            return progressHubContext.Clients.AllExcept(connectionIds).SendAsync("LeaveBalanceRemainingProgression", JsonConvert.SerializeObject(_progressMap));
        }

        /// <summary>
        /// Clear progress 
        /// </summary>
        /// <param name="progressHubContext"></param>
        /// <returns></returns>
        public static Task ClearProgress(IHubContext<LeaveBalanceRemainingProgressHub> progressHubContext)
        {
            if (progressHubContext == null)
            {
                return Task.Delay(0);
            }
            _progressMap = null;
            var connectionIds = (IReadOnlyList<string>)ConnectedUsers.Where(x => x != null && x.UserMail != ActiveAccountHelper.GetConnectedUserEmail()).Select(x => x.ConnectionId).ToList();
            return progressHubContext.Clients.AllExcept(connectionIds).SendAsync("LeaveBalanceRemainingProgression");
        }
    }
}
