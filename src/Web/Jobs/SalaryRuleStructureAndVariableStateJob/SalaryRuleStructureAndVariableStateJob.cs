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

namespace Web.Jobs.SalaryRuleStructureAndVariableStateJob
{
    public class SalaryRuleStructureAndVariableStateJob
    {
        #region fileds
        /// <summary>
        /// Default DbSettings
        /// </summary>
        private readonly DbSettings _defaultDbSettings;
        /// <summary>
        /// Logger
        /// </summary>
        private readonly ILogger<SalaryRuleStructureAndVariableStateJob> _logger;
        /// <summary>
        /// _serviceProvider
        /// </summary>
        private readonly IServiceProvider _serviceProvider;
        private readonly IServiceCompany _serviceCompany;
        #endregion

        public SalaryRuleStructureAndVariableStateJob(IOptions<AppSettings> appSettings, ILogger<SalaryRuleStructureAndVariableStateJob> logger,
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
                        const string interfaceName = "Application.Services.PayRoll.Interfaces.IServiceSalaryStructureValidityPeriod";
                        var assemblyInterface = Assembly.CreateQualifiedName("Application", interfaceName);
                        var generatedConnectionString = ManageDBConnections.BuildConnectionString(dbSettings, _defaultDbSettings);
                        IServiceSalaryStructureValidityPeriod serviceSalaryStructure = (IServiceSalaryStructureValidityPeriod)scope.ServiceProvider.GetRequiredService(Type.GetType(assemblyInterface));
                        serviceSalaryStructure.UpdateSalaryStructureWithSalaryRuleWithVariableState(generatedConnectionString);
                    }
                }
                catch (Exception e)
                {
                    ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                    exceptionLogger.ExceptionObject(typeof(SalaryRuleStructureAndVariableStateJob).Name, e);
                }
            }
        }
    }
}
