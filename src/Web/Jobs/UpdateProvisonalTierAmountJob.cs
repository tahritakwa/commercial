using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Quartz;
using Services.Specific.Sales.Interfaces;
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
    public class UpdateProvisonalTierAmountJob : IJob
    {
        #region fileds
        /// <summary>
        /// List of connection settings
        /// </summary>
        private readonly IServiceCompany _serviceCompany;
        /// <summary>
        /// Logger
        /// </summary>
        private readonly ILogger<UpdateProvisonalTierAmountJob> _logger;
        /// <summary>
        /// _serviceProvider
        /// </summary>
        private readonly IServiceProvider _serviceProvider;
        #endregion

        #region Methodes
        public UpdateProvisonalTierAmountJob(IServiceCompany serviceCompany, ILogger<UpdateProvisonalTierAmountJob> logger
            , IServiceProvider serviceProvider)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _serviceCompany = serviceCompany;
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
                        const string interfaceName = "Application.Services.Sales.Interfaces.IServiceTiers";
                        var assemblyInterface = Assembly.CreateQualifiedName("Application", interfaceName);
                        string generatedConnectionString = ManageDBConnections.BuildConnectionString(dbSettings);
                        IServiceTiers serviceTier = (IServiceTiers)scope.ServiceProvider.GetRequiredService(Type.GetType(assemblyInterface));
                        ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                        _logger.LogInformation("Begin Execute  UpdateProvisonalTierAmountJob vjob at" + DateTime.Now);
                        var date = DateTime.Now;
                        if (date.Day == 1)
                        {
                            serviceTier.UpdateProvisoanAmountForTier(generatedConnectionString);
                        }
                        _logger.LogInformation("End Execute UpdateProvisonalTierAmountJob" + DateTime.Now);
                    }
                }
            }
            catch (Exception e)
            {
                ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                exceptionLogger.ExceptionObject(typeof(UpdateProvisonalTierAmountJob).Name, e);
                throw;
            }
        }
        #endregion
    }
}
