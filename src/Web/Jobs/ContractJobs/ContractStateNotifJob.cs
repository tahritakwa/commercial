using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using ViewModels.Comparers;

namespace Web.Jobs.ContractJobs
{
    public class ContractStateNotifJob
    {
        #region fileds
        /// <summary>
        /// Default DbSettings
        /// </summary>
        private readonly DbSettings _defaultDbSettings;
        /// <summary>
        /// Logger
        /// </summary>
        private readonly ILogger<ContractStateNotifJob> _logger;
        /// <summary>
        /// _serviceProvider
        /// </summary>
        private readonly IServiceProvider _serviceProvider;
        private readonly IServiceCompany _serviceCompany;
        #endregion

        public ContractStateNotifJob(IOptions<AppSettings> appSettings, ILogger<ContractStateNotifJob> logger,
            IServiceProvider serviceProvider, IServiceCompany serviceCompany)
        {
            if (appSettings != null)
            {
                _defaultDbSettings = appSettings.Value.DbSettings;
            }
            _logger = logger;
            _serviceProvider = serviceProvider;
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
                        const string interfaceName = "Services.Specific.PayRoll.Interfaces.IServiceContract";
                        var assemblyInterface = Assembly.CreateQualifiedName("Services", interfaceName);
                        var generatedConnectionString = ManageDBConnections.BuildConnectionString(dbSettings, _defaultDbSettings);
                        IServiceContract serviceContract = (IServiceContract)scope.ServiceProvider.GetRequiredService(Type.GetType(assemblyInterface));
                        serviceContract.UpdateContractAndRemunerationStateWithSendNotif(generatedConnectionString);
                    }
                }
                catch (Exception e)
                {
                    ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                    exceptionLogger.ExceptionObject(typeof(ContractStateNotifJob).Name, e);
                }
            }
        }
    }
}
