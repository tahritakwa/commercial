using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Quartz;
using Services.Specific.Ecommerce.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;
using ViewModels.Comparers;

namespace Web.Jobs
{
    public class EcommerceGetAddOrEditProductsJob : IJob
    {
        #region fileds
        /// <summary>
        /// List of connection settings
        /// </summary>
        private readonly DbSettings _dbConnectionSetting;
        /// <summary>
        /// Logger
        /// </summary>
        private readonly ILogger<EcommerceGetAddOrEditProductsJob> _logger;
        /// <summary>
        /// _serviceProvider
        /// </summary>
        private readonly IServiceProvider _serviceProvider;
        static SemaphoreSlim semaphoreSlim = new SemaphoreSlim(1, 1);
        #endregion

        #region Methodes
        public EcommerceGetAddOrEditProductsJob(IOptions<AppSettings> appSettings, ILogger<EcommerceGetAddOrEditProductsJob> logger
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

                using (var scope = _serviceProvider.CreateScope())
                {

                    const string interfaceName = "Services.Specific.Ecommerce.Interfaces.IServiceEcommerce";
                    var assemblyInterface = Assembly.CreateQualifiedName("Services", interfaceName);

                    string generatedConnectionString = ManageDBConnections.BuildConnectionString(_dbConnectionSetting);
                    IServiceEcommerce serviceEcommerce = (IServiceEcommerce)scope.ServiceProvider.GetRequiredService(Type.GetType(assemblyInterface));


                    await serviceEcommerce.GetAndUpdateAddedProductsFromEcommerce(generatedConnectionString);


                }
            }
            catch (Exception e)
            {
                ExceptionLogger exceptionLogger = new ExceptionLogger(_logger);
                exceptionLogger.ExceptionObject(typeof(EcommerceGetAddOrEditProductsJob).Name, e);
                throw;
            }
            finally
            {
                //When the task is ready, release the semaphore. It is vital to ALWAYS release the semaphore when we are ready, or else we will end up with a Semaphore that is forever locked.
                //This is why it is important to do the Release within a try...finally clause; program execution may crash or take a different path, this way you are guaranteed execution
                semaphoreSlim.Release();
            }
        }
        #endregion
    }
}




