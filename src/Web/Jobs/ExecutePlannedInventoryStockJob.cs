using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Quartz;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using ViewModels.Comparers;

namespace Web.Jobs
{
    public class ExecutePlannedInventoryStockJob : IJob
    {
        #region fileds
        /// <summary>
        /// List of connection settings
        /// </summary>
        private readonly List<DbSettings> _dbConnectionSettings;
        /// <summary>
        /// Logger
        /// </summary>
        private readonly ILogger<ExecutePlannedInventoryStockJob> _logger;
        /// <summary>
        /// _serviceProvider
        /// </summary>
        private readonly IServiceProvider _serviceProvider;

        private readonly IServiceCompany _serviceCompany;

        #endregion

        #region Methodes
        public ExecutePlannedInventoryStockJob(IOptions<AppSettings> appSettings, ILogger<ExecutePlannedInventoryStockJob> logger
            , IServiceProvider serviceProvider, IServiceCompany serviceCompany)
        {
            _serviceProvider = serviceProvider;
            _serviceCompany = serviceCompany;
            _logger = logger;

        }
#pragma warning disable CS1998 // This async method lacks 'await' operators and will run synchronously. Consider using the 'await' operator to await non-blocking API calls, or 'await Task.Run(...)' to do CPU-bound work on a background thread.
        /// <summary>
        /// Execute
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public async Task Execute(IJobExecutionContext context)
#pragma warning restore CS1998 // This async method lacks 'await' operators and will run synchronously. Consider using the 'await' operator to await non-blocking API calls, or 'await Task.Run(...)' to do CPU-bound work on a background thread.
        {
            try
            {
                List<DbSettings> _dbConnectionSettings = _serviceCompany.GetAllDbSettings().ToList();
                foreach (DbSettings dbSettings in _dbConnectionSettings)
                {
                    using (var scope = _serviceProvider.CreateScope())
                    {
                        const string interfaceName = "Application.Services.Inventory.Interfaces.IServiceStockDocument";
                        var assemblyInterface = Assembly.CreateQualifiedName("Application", interfaceName);
                        IServiceStockDocument serviceDocument = (IServiceStockDocument)scope.ServiceProvider.GetRequiredService(Type.GetType(assemblyInterface));
                        string generatedConnectionString = ManageDBConnections.BuildConnectionString(dbSettings);
                        serviceDocument.AddPlannedInventoryDocumentLines(generatedConnectionString);
                    }
                }
            }
            catch (Exception e)
            {
                ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                exceptionLogger.ExceptionObject(typeof(ExecutePlannedInventoryStockJob).Name, e);
                throw;
            }
        }
        #endregion
    }
}
