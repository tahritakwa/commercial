using Hangfire;
using System;
using Web.Jobs;
using Web.Jobs.AnnualInterviewJobs;
using Web.Jobs.CandidateJobs;
using Web.Jobs.ContractJobs;
using Web.Jobs.EmployeeJobs;
using Web.Jobs.EmployeeTeamStateJob;
using Web.Jobs.EmplyeeExitJobs;
using Web.Jobs.LeaveBalanceRemainingJobs;
using Web.Jobs.SalaryRuleStructureAndVariableStateJob;
using Web.Jobs.TimeSheetJobs;

namespace Web.HangFire
{
    public class HangFireJobScheduler
    {
        public static void ScheduleRecurringJobs()
        {
            /*SendAnnualInterviewNotificationJob*/
            RecurringJob.RemoveIfExists(nameof(SendAnnualInterviewNotificationJob));
            RecurringJob.AddOrUpdate<SendAnnualInterviewNotificationJob>(nameof(SendAnnualInterviewNotificationJob),
                job => job.StartJob(),
                HangfireCronConstant.MidnightDaily, TimeZoneInfo.Local);

            /*SendSubmitTimesheetNotificationMailJob*/
            RecurringJob.RemoveIfExists(nameof(SendSubmitTimesheetNotificationMailJob));
            RecurringJob.AddOrUpdate<SendSubmitTimesheetNotificationMailJob>(nameof(SendSubmitTimesheetNotificationMailJob),
                job => job.StartJob(),
                HangfireCronConstant.MidnightDaily, TimeZoneInfo.Local);

            /*SendValidateTimesheetNotificationMailJob*/
            RecurringJob.RemoveIfExists(nameof(SendValidateTimesheetNotificationMailJob));
            RecurringJob.AddOrUpdate<SendValidateTimesheetNotificationMailJob>(nameof(SendValidateTimesheetNotificationMailJob),
                job => job.StartJob(),
                HangfireCronConstant.MidnightDaily, TimeZoneInfo.Local);

            /*GetCandidateFromWebPortal*/
            RecurringJob.RemoveIfExists(nameof(GetCandidateFromWebPortal));
            RecurringJob.AddOrUpdate<GetCandidateFromWebPortal>(nameof(GetCandidateFromWebPortal),
                job => job.StartJob(),
                HangfireCronConstant.MidnightDaily, TimeZoneInfo.Local);

            /*SendAlertMaterialRecoveryMailJob*/
            RecurringJob.RemoveIfExists(nameof(SendAlertMaterialRecoveryMailJob));
            RecurringJob.AddOrUpdate<SendAlertMaterialRecoveryMailJob>(nameof(SendAlertMaterialRecoveryMailJob),
                job => job.StartJob(),
                HangfireCronConstant.MidnightDaily, TimeZoneInfo.Local);

            /*CalculateMonthlyTypeLeaveBalanceRemainingJob*/
            RecurringJob.RemoveIfExists(nameof(CalculateMonthlyTypeLeaveBalanceRemainingJob));
            RecurringJob.AddOrUpdate<CalculateMonthlyTypeLeaveBalanceRemainingJob>(nameof(CalculateMonthlyTypeLeaveBalanceRemainingJob),
                job => job.StartJob(),
                HangfireCronConstant.MidnightMonthly, TimeZoneInfo.Local);

            /*CalculateYearlyTypeLeaveBalanceRemainingJob*/
            RecurringJob.RemoveIfExists(nameof(CalculateYearlyLeaveBalanceRemainingJob));
            RecurringJob.AddOrUpdate<CalculateYearlyLeaveBalanceRemainingJob>(nameof(CalculateYearlyLeaveBalanceRemainingJob),
                job => job.StartJob(),
                HangfireCronConstant.MidnightAnnually, TimeZoneInfo.Local);

            /*CalculateAverageSalesPerDayJob*/
            RecurringJob.RemoveIfExists(nameof(CalculateAverageSalesPerDayJob));
            RecurringJob.AddOrUpdate<CalculateAverageSalesPerDayJob>(nameof(CalculateAverageSalesPerDayJob),
                job => job.StartJob(),
                HangfireCronConstant.MidnightDaily, TimeZoneInfo.Local);

            /*Contract state Job*/
            RecurringJob.RemoveIfExists(nameof(ContractStateNotifJob));
            RecurringJob.AddOrUpdate<ContractStateNotifJob>(nameof(ContractStateNotifJob),
                job => job.StartJob(),
                HangfireCronConstant.MidnightDaily, TimeZoneInfo.Local);
            /*Salary state Job*/
            RecurringJob.RemoveIfExists(nameof(SalaryRuleStructureAndVariableStateJob));
            RecurringJob.AddOrUpdate<SalaryRuleStructureAndVariableStateJob>(nameof(SalaryRuleStructureAndVariableStateJob),
                job => job.StartJob(),
                HangfireCronConstant.MidnightMonthly, TimeZoneInfo.Local);
            /*EmployeeTeam state Job*/
            RecurringJob.RemoveIfExists(nameof(UpdateEmployeeTeamStateJob));
            RecurringJob.AddOrUpdate<UpdateEmployeeTeamStateJob>(nameof(UpdateEmployeeTeamStateJob),
                job => job.StartJob(),
                HangfireCronConstant.MidnightDaily, TimeZoneInfo.Local);

            /*Employee statud Job*/
            RecurringJob.RemoveIfExists(nameof(UpdateEmployeeStatusJob));
            RecurringJob.AddOrUpdate<UpdateEmployeeStatusJob>(nameof(UpdateEmployeeStatusJob),
                job => job.StartJob(),
                HangfireCronConstant.MidnightDaily, TimeZoneInfo.Local);
        }
    }
}
