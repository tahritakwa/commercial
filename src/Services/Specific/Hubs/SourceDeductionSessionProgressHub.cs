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
    public class SourceDeductionSessionProgressHub : BaseHub
    {
        private static IDictionary<int, ProgressBar> _progressMap = new Dictionary<int, ProgressBar>();

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
        /// <returns></returns>
        public static Task SendProgress(int IdSession, int max, IHubContext<SourceDeductionSessionProgressHub> progressHubContext)
        {
            if (IdSession.Equals(0) || progressHubContext == null)
            {
                return Task.Delay(0);
            }
            // Create new instance of progress if it not exist
            if (!_progressMap.ContainsKey(IdSession))
            {
                _progressMap.Add(IdSession, new ProgressBar(IdSession, max));
            }
            _progressMap[IdSession].State = ProgressBarState.Pending;
            _progressMap[IdSession].Treated++;
            _progressMap[IdSession].Progression = Math.Floor(_progressMap[IdSession].Treated * 100 / (float)_progressMap[IdSession].MaximalValue);
            if (_progressMap[IdSession].Treated == max)
            {
                _progressMap[IdSession].State = ProgressBarState.Completed;
            }
            var connectionIds = (IReadOnlyList<string>)ConnectedUsers.Where(x => x != null && x.UserMail != ActiveAccountHelper.GetConnectedUserEmail()).Select(x => x.ConnectionId).ToList();
            return progressHubContext.Clients.AllExcept(connectionIds).SendAsync("SourceDeductionSessionProgression", JsonConvert.SerializeObject(_progressMap[IdSession]));
        }

        /// <summary>
        /// Clear progress 
        /// </summary>
        /// <param name="IdSession"></param>
        /// <param name="progressHubContext"></param>
        /// <returns></returns>
        public static Task ClearProgress(int IdSession, IHubContext<SourceDeductionSessionProgressHub> progressHubContext)
        {
            if (IdSession.Equals(0) || progressHubContext == null)
            {
                return Task.Delay(0);
            }
            _progressMap.Remove(IdSession);
            var connectionIds = (IReadOnlyList<string>)ConnectedUsers.Where(x => x != null && x.UserMail != ActiveAccountHelper.GetConnectedUserEmail()).Select(x => x.ConnectionId).ToList();
            return progressHubContext.Clients.AllExcept(connectionIds).SendAsync("SourceDeductionSessionProgression");
        }
    }
}

