using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using ViewModels.Comparers;

namespace Web.Jobs.TimeSheetJobs
{
    public class SendSubmitTimesheetNotificationMailJob
    {
        #region fileds
        /// <summary>
        /// Default DbSettings
        /// </summary>
        private readonly DbSettings _defaultDbSettings;
        /// <summary>
        /// List of connection settings
        /// </summary>
        private readonly List<DbSettings> _dbConnectionSettings;
        /// <summary>
        /// Logger
        /// </summary>
        private readonly ILogger<SendSubmitTimesheetNotificationMailJob> _logger;
        /// <summary>
        /// _serviceProvider
        /// </summary>
        private readonly IServiceProvider _serviceProvider;
        private readonly SmtpSettings _smtpSettings;
        private readonly IServiceCompany _serviceCompany;
        #endregion

        public SendSubmitTimesheetNotificationMailJob(IOptions<AppSettings> appSettings, ILogger<SendSubmitTimesheetNotificationMailJob> logger,
            IServiceProvider serviceProvider, IOptions<SmtpSettings> smtpSettings, IServiceCompany serviceCompany)
        {
            if (appSettings != null)
            {
                _defaultDbSettings = appSettings.Value.DbSettings;
            }
            _logger = logger;
            _serviceProvider = serviceProvider;
            _smtpSettings = smtpSettings.Value;
            _serviceCompany = serviceCompany;
        }

        public void StartJob()
        {
            // Get list of connection settings
            List<DbSettings> _dbConnectionSettings = _serviceCompany.GetAllDbSettings().ToList();
            foreach (DbSettings dbSettings in _dbConnectionSettings)
            {
                try
                {
                    using (var scope = _serviceProvider.CreateScope())
                    {
                        const string interfaceName = "Application.Services.RH.Interfaces.IServiceTimeSheetJobs";
                        var assemblyInterface = Assembly.CreateQualifiedName("Application", interfaceName);
                        var generatedConnectionString = ManageDBConnections.BuildConnectionString(dbSettings, _defaultDbSettings);
                        IServiceTimeSheetJobs serviceTimeSheetJobs = (IServiceTimeSheetJobs)scope.ServiceProvider.GetRequiredService(Type.GetType(assemblyInterface));
                        serviceTimeSheetJobs.SendSubmitTimeSheetNotification(generatedConnectionString, _smtpSettings);
                    }
                }
                catch (Exception e)
                {
                    ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                    exceptionLogger.ExceptionObject(typeof(SendSubmitTimesheetNotificationMailJob).Name, e);
                }
            }
        }
    }
}
