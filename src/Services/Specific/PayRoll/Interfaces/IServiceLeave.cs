using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceLeave : IService<LeaveViewModel, Leave>
    {
        DataSourceResult<LeaveViewModel> GetEmployeeLeaveRequests(string userMail, PredicateFormatViewModel predicate, DateTime? month, bool onlyFirstLevelOfHierarchy = false, bool isAdmin = false);
        DataSourceResult<LeaveViewModel> GetEmployeeConnectedLeave(PredicateFormatViewModel predicateModel, string userMail);
        void PrepareAndSendMail(MailBrodcastConfigurationViewModel configModel, string userMail, string action,
            LeaveViewModel oldLeave, SmtpSettings smtpSettings);
        IList<KeyValuePair<string, TimeSpan>> GetHoursPeriodOfDate(DateTime date);
        KeyValuePair<string, TimeSpan> GetStartTimeOfPeriod(DateTime date);
        KeyValuePair<string, TimeSpan> GetEndTimeOfPeriod(DateTime date);
        void CalculateNumberOfDaysAndHourOfLeaveBalance(LeaveViewModel leaveViewModel);
        PeriodViewModel VerifyPeriodOfDate(DateTime date);
        IList<LeaveViewModel> GetTwoLeavesDecomposedFromNegativeBalanceLeave(LeaveViewModel leaveViewModel);
        bool CheckUserIsTeamManagerOrUpperHierrarchy(int idEmployee, string userMail);
        DayHour CalculateNumberOfDaysAndHourOfAllLeaveRequest(LeaveTypeViewModel leaveType, int idEmployee, double numberOfHourPerDay = 0, int idCurrentLeave = 0);
        List<LeaveViewModel> GetLeaveFromListId(List<int> listIdLeaves);
        void ValidateMassiveLeaves(List<LeaveViewModel> listOfLeaves, string userMail);
        void DeleteMassiveLeave(List<int> listIdLeaves, string userMail);
        void RefuseMassiveLeave(List<int> listIdLeaves, string userMail);
        void AddMassiveLeaves(List<LeaveViewModel> listOfLeaves);
        void ValidateLeaveRequest(LeaveViewModel leave);
        void MassiveSendLeaveBalanceRemainingEmails(LeaveBalanceRemainingFilter leaveBalanceRemainingFilter, string userMail);
    }
}
