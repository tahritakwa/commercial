using Quartz;
using Quartz.Impl;
using Quartz.Spi;
using System.Threading.Tasks;

namespace Web.Quartz
{
    /// <summary>
    /// Configuration for the Quartz Scheduler
    /// </summary>
    public class Quartz
    {
        // The used scheduler
        private IScheduler _scheduler;

        /// <summary>
        /// Used schedulers
        /// </summary>
        public static IScheduler Scheduler { get { return Instance._scheduler; } }

        // Singleton
        private static Quartz _instance = null;

        /// <summary>
        /// Singleton
        /// </summary>
        public static Quartz Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new Quartz();
                }
                return _instance;
            }
        }

        private Quartz()
        {
            // Initialize
            Init().Wait();
        }

        private async Task Init()
        {
            // Scheduler set with standard scheduler factory
            _scheduler = await new StdSchedulerFactory().GetScheduler();
        }

        /// <summary>
        /// Defines the JobFactory from which the jobs are generated
        /// </summary>
        /// <param name="jobFactory"></param>
        /// <returns></returns>
        public IScheduler UseJobFactory(IJobFactory jobFactory)
        {
            Scheduler.JobFactory = jobFactory;
            return Scheduler;
        }

        /// <summary>
        /// Adds a new job to the scheduler
        /// </summary>
        /// <typeparam name="T">Job that is generated</typeparam>
        /// <param name="name">Name des Jobs</param>
        /// <param name="group">Group of jobs</param>
        /// <param name="interval">Interval between execution in seconds</param>
        public static async Task AddJobWithInterval<T>(string name, string group, int interval)
            where T : IJob
        {
            // Create a job
            IJobDetail job = JobBuilder.Create<T>()
                .WithIdentity(name, group)
                .Build();

            // Create triggers
            ITrigger jobTrigger = TriggerBuilder.Create()
                .WithIdentity(name + "Trigger", group)
                .StartNow() // Start now
                .WithSimpleSchedule(t => t.WithIntervalInSeconds(interval).RepeatForever()) // With repetition every interval second
                .Build();

            // Attach job
            await Scheduler.ScheduleJob(job, jobTrigger);
        }
        /// <summary>
        /// AddMonthlyJob
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="name"></param>
        /// <param name="group"></param>
        /// <param name="dayOfMonth"></param>
        /// <returns></returns>
        public static async Task AddMonthlyJob<T>(string name, string group, int dayOfMonth)
            where T : IJob
        {
            // Create a job
            IJobDetail job = JobBuilder.Create<T>()
                .WithIdentity(name, group)
                .Build();

            // Create triggers
            ITrigger jobTrigger = TriggerBuilder.Create()
                .WithIdentity(name + "Trigger", group)
                .StartNow() // Start now
                .WithSchedule(CronScheduleBuilder.MonthlyOnDayAndHourAndMinute(dayOfMonth, 0, 0)) // With repetition every month at day
                .Build();

            // Attach job
            await Scheduler.ScheduleJob(job, jobTrigger);
        }
        /// <summary>
        /// AddDailyJob
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="name"></param>
        /// <param name="group"></param>
        /// <param name="hourOfDay"></param>
        /// <returns></returns>
        public static async Task AddDailyJob<T>(string name, string group, int hourOfDay, int minute = 0)
            where T : IJob
        {
            // Create a job
            IJobDetail job = JobBuilder.Create<T>()
                .WithIdentity(name, group)
                .Build();

            // Create triggers
            ITrigger jobTrigger = TriggerBuilder.Create()
                .WithIdentity(name + "Trigger", group)
                .StartNow() // Start now
                .WithSchedule(CronScheduleBuilder.DailyAtHourAndMinute(hourOfDay, minute))// With repetition every dat at hour
                .Build();

            // Attach job   
            await Scheduler.ScheduleJob(job, jobTrigger);
        }

        /// <summary>
        /// Started the Scheduler
        /// </summary>
        public static void Start()
        {
            Scheduler.Start();
        }
    }
}
