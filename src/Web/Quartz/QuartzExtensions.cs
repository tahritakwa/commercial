using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Quartz.Spi;
using Settings.Config;
using System;
using System.Threading.Tasks;
using Web.Jobs;

namespace Web.Quartz
{
    public static class QuartzExtensions
    {
        static AppSettings _appSettings;
        /// <summary>
        /// Extension methode start quartz
        /// </summary>
        /// <param name="app"></param>
        public static void UseQuartz(this IApplicationBuilder app)
        {
            // Job Factory through IOC container
            var jobFactory = (IJobFactory)app.ApplicationServices.GetService(typeof(IJobFactory));
            // Set job factory
            Quartz.Instance.UseJobFactory(jobFactory);
            // Run Quartz
            Quartz.Start();
        }
        /// <summary>
        /// Extension methode Add Quartz
        /// </summary>
        /// <param name="services"></param>
        /// <param name="container"></param>
        public static void AddQuartz(this IServiceCollection services, IServiceProvider container, AppSettings appSettings)
        {
            _appSettings = appSettings;
            Quartz.Instance.UseJobFactory(new IoCJobFactory(container));
            // Add jobs
            AddQuartzJobs().Wait();
        }
        /// <summary>
        /// Add quartz jobs to the scheduler
        /// </summary>
        public static async Task AddQuartzJobs()
        {
            // Must be mort tested after new strategy of Jobs
            await Quartz.AddDailyJob<CheckStockJob>("CheckStockJob", "DailyJobGroup", 1);
            await Quartz.AddDailyJob<UpdateProvisonalTierAmountJob>("UpdateProvisonalTierAmountJob", "DailyJobGroup", 1, 20);

            await Quartz.AddDailyJob<EcommerceSendPriceQuantityJob>("EcommerceSendPriceQuantity", "DailyJobGroup", 0);
            await Quartz.AddJobWithInterval<EcommerceGetBLsJob>("EcommerceGetBLs", "JobWithIntervalGroup",
                _appSettings.ECommerceConfig.FrequencyByMinuteForExecuteJobForEcommerceGetBLs * 60);

            await Quartz.AddJobWithInterval<EcommerceGetAddOrEditProductsJob>("EcommerceGetAddOrEditProducts", "JobWithIntervalGroup",
                _appSettings.ECommerceConfig.FrequencyByMinuteForExecuteJobForEcommerceGetAddOrEditProducts * 60);

            await Quartz.AddJobWithInterval<DisconnectUser>("DisconnectUser", "JobWithIntervalGroup", 7200);
        }
        /// <summary>
        /// Inject jobs
        /// </summary>
        /// <param name="servicesCollection"></param>
        public static void InjectJobs(this IServiceCollection servicesCollection)
        {
            // Inject jobs 
            servicesCollection.AddScoped<FinancialCommitmentJob>();
            servicesCollection.AddScoped<CheckStockJob>();
            servicesCollection.AddScoped<UpdateProvisonalTierAmountJob>();
            servicesCollection.AddScoped<CalculateAverageSalesPerDayJob>();
            //servicesCollection.AddScoped<EcommerceSendPriceQuantityJob>();
            //servicesCollection.AddScoped<EcommerceGetAddOrEditProductsJob>();
            //servicesCollection.AddScoped<EcommerceGetBLsJob>();
            servicesCollection.AddScoped<DisconnectUser>();
            // inject jobs factory
            servicesCollection.AddTransient<IJobFactory, IoCJobFactory>(
                (provider) =>
                {
                    return new IoCJobFactory(provider);
                });
            servicesCollection.AddSingleton(Quartz.Scheduler);
        }
    }
}
