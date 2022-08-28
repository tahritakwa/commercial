using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Persistence.Context;
using Persistence.Entities;

using Quartz;
using Services.Specific.Hubs;
using Services.Specific.Jobs.FinancialCommitmentService;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ViewModels.Comparers;

namespace Web.Jobs
{
    public class FinancialCommitmentJob : IJob, IDisposable
    {
        /// <summary>
        /// Default DbSettings
        /// </summary>
        private readonly DbSettings _defaultDbSettings;
        /// <summary>
        /// Context of signalR hub
        /// </summary>
        private readonly IHubContext<NotificationHub> _reminderHubContext;
        /// <summary>
        /// Specific service for the job
        /// </summary>
        private readonly FinancialCommitmentJobService _financialCommitmentJobService;
        /// <summary>
        /// List of connection settings
        /// </summary>
        private readonly List<DbSettings> _dbConnectionSettings;
        /// <summary>
        /// EF caching
        /// </summary>
        /// <summary>
        /// Logger
        /// </summary>
        private readonly ILogger<FinancialCommitmentJob> _logger;
        /// <summary>
        /// _contextAccessor
        /// </summary>
        private readonly IHttpContextAccessor _contextAccessor;
        private readonly IServiceCompany _serviceCompany;
        private readonly IMemoryCache _memoryCache;
        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="reminderHub"></param>
        /// <param name="companies"></param>
        /// <param name="iEFCacheServiceProvider"></param>
        /// <param name="logger"></param>
        public FinancialCommitmentJob(IHubContext<NotificationHub> reminderHubContext, IOptions<AppSettings> appSettings,
             ILogger<FinancialCommitmentJob> logger, IHttpContextAccessor contextAccessor, IServiceCompany serviceCompany, 
            IMemoryCache memoryCache)
        {
            if (appSettings != null)
            {
                _defaultDbSettings = appSettings.Value.DbSettings;
            }
            _reminderHubContext = reminderHubContext;
            _financialCommitmentJobService = new FinancialCommitmentJobService();
           
            _serviceCompany = serviceCompany;
            _logger = logger;
            _contextAccessor = contextAccessor;
            _memoryCache = memoryCache;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool isdisposing)
        {
            if (isdisposing)
            {
                _financialCommitmentJobService.Dispose();
            }
        }

        /// <summary>
        /// Main methode of the Job
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public async Task Execute(IJobExecutionContext context)
        {
            try
            {
                // Get list of connection settings
                List<DbSettings> _dbConnectionSettings = _serviceCompany.GetAllDbSettings().ToList();
                foreach (DbSettings dbSettings in _dbConnectionSettings)
                {
                    var optionsBuilder = new DbContextOptionsBuilder<StarkContextFactory>();
                    optionsBuilder.UseSqlServer(ManageDBConnections.BuildConnectionString(dbSettings, _defaultDbSettings));
                    using (StarkContextFactory dbcontext = new StarkContextFactory(optionsBuilder.Options, _contextAccessor, _memoryCache, null, isIocCall: false))
                    {
                        _financialCommitmentJobService.SetDbContext(dbcontext);
                        List<MsgNotification> msgNotificationsToSend = await _financialCommitmentJobService.Check();
                        foreach (var msgNotification in msgNotificationsToSend)
                        {
                            // Call the reminder Hub 
                            await NotificationHub.SendFinancialCommitmentReminderNotications(msgNotification, _reminderHubContext);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                exceptionLogger.ExceptionObject(typeof(FinancialCommitmentJob).Name, e);
                throw;
            }
        }
    }
}
