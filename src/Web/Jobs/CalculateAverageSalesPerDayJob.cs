using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using ViewModels.Comparers;

namespace Web.Jobs
{
    public class CalculateAverageSalesPerDayJob
    {
        #region fileds
        /// <summary>
        /// Default DbSettings
        /// </summary>
        private readonly DbSettings _defaultDbSettings;
        /// <summary>
        /// Logger
        /// </summary>
        private readonly ILogger<CalculateAverageSalesPerDayJob> _logger;
        /// <summary>
        /// _serviceProvider
        /// </summary>
        private readonly IServiceProvider _serviceProvider;
        /// <summary>
        /// Service Company for retrieve the list of master companies 
        /// </summary>
        private readonly IServiceCompany _serviceCompany;
        #endregion

        #region Methodes
        public CalculateAverageSalesPerDayJob(IOptions<AppSettings> appSettings, ILogger<CalculateAverageSalesPerDayJob> logger
            , IServiceProvider serviceProvider, IServiceCompany serviceCompany)
        {
            if (appSettings != null)
            {
                _defaultDbSettings = appSettings.Value.DbSettings;
            }
            _serviceProvider = serviceProvider;
            _serviceCompany = serviceCompany;
            _logger = logger;

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
                        const string interfaceName = "Application.Services.Sales.Interfaces.IServiceDocument";
                        var assemblyInterface = Assembly.CreateQualifiedName("Application", interfaceName);
                        var generatedConnectionString = ManageDBConnections.BuildConnectionString(dbSettings, _defaultDbSettings);
                        IServiceDocument serviceDocument = (IServiceDocument)scope.ServiceProvider.GetRequiredService(Type.GetType(assemblyInterface));
                        serviceDocument.CalculateAverageSalesPerDay(generatedConnectionString);
                    }
                }
                catch (Exception e)
                {
                    ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                    exceptionLogger.ExceptionObject(typeof(CalculateAverageSalesPerDayJob).Name, e);
                }
            }
        }
        #endregion
    }
}
