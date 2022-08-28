using Quartz;
using Services.Specific.Hubs;
using System.Collections.Generic;
using System.Threading.Tasks;
using ViewModels.DTO.Common;

namespace Web.Jobs
{
    public class DisconnectUser : IJob
    {




        #region Methodes
        public DisconnectUser()
        {
        }
#pragma warning disable CS1998 // This async method lacks 'await' operators and will run synchronously. Consider using the 'await' operator to await non-blocking API calls, or 'await Task.Run(...)' to do CPU-bound work on a background thread.
        /// <summary>
        /// Execute
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public async Task Execute(IJobExecutionContext context)
        {
            BaseHub.ConnectedUsers = new List<UserDetail>();
        }
        #endregion
    }
}
