using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceTimeSheet : IService<TimeSheetViewModel, TimeSheet>
    {
        TimeSheetViewModel GetEmployeeTimeSheet(int idEmployee, DateTime month);
        IList<TimeSheetViewModel> GetYearTimeSheet(int idEmployee, DateTime year);
        TimeSheetViewModel ValidateTimeSheet(TimeSheetViewModel timeSheetViewModel, string userMail);
        object DefinitiveValidateTimeSheet(int idTimeSheet, string userMail);
        DayHour TimeValueChange(DateTime date, TimeSpan startTime, TimeSpan endTime);

        int SendEmail(int idEmployee, DateTime startDate, string userMail);
        void TimeSheetFixRequest(int idTimeSheet, string userMail);
        NumberOfDaysDayHour GetNumberOfDayWorkedPerContract(DateTime startDate, DateTime endDate, int idEmployee, DateTime month);
        bool CheckUserIsTeamManagerOrUpperHierrarchy(int idEmployee, string userMail);
        DataSourceResult<TimeSheetViewModel> GetEmployeeTimeSheetRequests(string userMail, PredicateFormatViewModel predicate, bool isAdmin);
        IList<TimeSheetViewModel> GetAvailableEmployeeByTimeSheet(DateTime endDate);
        List<TimeSheetViewModel> GetTimesheetFromListId(List<int> listIdTimesheets);
        void ValidateMassiveTimesheets(List<TimeSheetViewModel> listOfTimesheets, string userMail);
        AttendanceViewModel NumberOfDaysWorkedByContractDependOnTimeSheet(ContractViewModel contractViewModel, DateTime month, double daysOfWork, bool isForPreview = false);
        void MassiveTimeSheetFixRequest(List<int> listOfTimesheets, string userMail);
    }
}
