using Quartz;
using Quartz.Spi;
using System;

namespace Web.Quartz
{
    public class IoCJobFactory : IJobFactory
    {
        /// <summary>
        /// service provider
        /// </summary>
        private readonly IServiceProvider _factory;

        /// <summary>
        /// factory constructor
        /// </summary>
        /// <param name="factory"></param>
        public IoCJobFactory(IServiceProvider factory)
        {
            _factory = factory;
        }
        /// <summary>
        /// add new job
        /// </summary>
        /// <param name="bundle"></param>
        /// <param name="scheduler"></param>
        /// <returns></returns>
        public IJob NewJob(TriggerFiredBundle bundle, IScheduler scheduler)
        {
            return _factory.GetService(bundle.JobDetail.JobType) as IJob;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="job"></param>
        public void ReturnJob(IJob job)
        {
            var disposable = job as IDisposable;
            if (disposable != null)
            {
                disposable.Dispose();
            }
        }
    }
}
