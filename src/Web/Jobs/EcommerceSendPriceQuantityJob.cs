using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Quartz;
using Serilog.Events;
using Services.Specific.Ecommerce.Interfaces;
using Settings.Config;
using System;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Utilities.DataUtilities;
using ViewModels.Comparers;

namespace Web.Jobs
{
    public class EcommerceSendPriceQuantityJob : IJob
    {
        #region fileds
        /// <summary>
        /// List of connection settings
        /// </summary>
        private readonly DbSettings _dbConnectionSetting;
        /// <summary>
        /// Logger
        /// </summary>
        private readonly ILogger<EcommerceSendPriceQuantityJob> _logger;
        /// <summary>
        /// _serviceProvider
        /// </summary>
        private readonly IServiceProvider _serviceProvider;
        static readonly SemaphoreSlim semaphoreSlim = new SemaphoreSlim(1, 1);
        #endregion

        #region Methodes
        public EcommerceSendPriceQuantityJob(IOptions<AppSettings> appSettings, ILogger<EcommerceSendPriceQuantityJob> logger
            , IServiceProvider serviceProvider)
        {
            _serviceProvider = serviceProvider;
            if (appSettings != null)
            {
                _dbConnectionSetting = appSettings.Value.ECommerceConfig.DbSettings;
            }
            _logger = logger;

        }
        /// <summary>
        /// Execute
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public async Task Execute(IJobExecutionContext context)
        {
            await semaphoreSlim.WaitAsync();
            try
            {
                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.BEGIN_SYNCHRONIZE_ALL_PRODUCTS_DETAILS_BEFOR_JOB);

                using (var scope = _serviceProvider.CreateScope())
                {

                    const string interfaceName = "Services.Specific.Ecommerce.Interfaces.IServiceJobTable";
                    var assemblyInterface = Assembly.CreateQualifiedName("Services", interfaceName);

                    string generatedConnectionString = ManageDBConnections.BuildConnectionString(_dbConnectionSetting);
                    IServiceJobTable serviceJobTable = (IServiceJobTable)scope.ServiceProvider.GetRequiredService(Type.GetType(assemblyInterface));


                    await serviceJobTable.SynchronizeAllProdcutsWithDetailsToEcommerceAsync(generatedConnectionString);


                }
            }
            catch (Exception e)
            {
                throw;
            }
            finally
            {
                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.BEGIN_SYNCHRONIZE_ALL_PRODUCTS_DETAILS_BEFOR_JOB);
                //When the task is ready, release the semaphore. It is vital to ALWAYS release the semaphore when we are ready, or else we will end up with a Semaphore that is forever locked.
                //This is why it is important to do the Release within a try...finally clause; program execution may crash or take a different path, this way you are guaranteed execution
                semaphoreSlim.Release();
            }
        }
        #endregion
    }
}




