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

namespace Web.Jobs.EmployeeTeamStateJob
{
    public class UpdateEmployeeTeamStateJob
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
        private readonly ILogger<UpdateEmployeeTeamStateJob> _logger;
        /// <summary>
        /// _serviceProvider
        /// </summary>
        private readonly IServiceProvider _serviceProvider;
        private readonly IServiceCompany _serviceCompany;
        #endregion

        public UpdateEmployeeTeamStateJob(IOptions<AppSettings> appSettings, ILogger<UpdateEmployeeTeamStateJob> logger,
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
                        const string interfaceName = "Services.Specific.PayRoll.Interfaces.IServiceEmployeeTeam";
                        var assemblyInterface = Assembly.CreateQualifiedName("Services", interfaceName);
                        var generatedConnectionString = ManageDBConnections.BuildConnectionString(dbSettings, _defaultDbSettings);
                        IServiceEmployeeTeam serviceEmployeeTeam = (IServiceEmployeeTeam)scope.ServiceProvider.GetRequiredService(Type.GetType(assemblyInterface));
                        serviceEmployeeTeam.UpdateStateAssignedEmployeeTeamJob(generatedConnectionString);
                    }
                }
                catch (Exception e)
                {
                    ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                    exceptionLogger.ExceptionObject(typeof(UpdateEmployeeTeamStateJob).Name, e);
                }
            }
        }
    }
}
