using System.Collections.Generic;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;

namespace Services.Reporting.Interfaces
{
    public interface IRhServiceReporting
    {
        TimeSheetReportInformationsViewModel GetTimeSheetInformations(int idTimeSheet, int idProject);
        IEnumerable<TimeSheetLineReportInformationsViewModel> GetTimeSheetLines(int idTimeSheet, int idProject);
        ExitEmployeeInformationsViewModel GetExitEmployeeLeaveInformations(int idExitEmployee, int period, int idLeaveType);
        IList<ExitEmployeeLeaveLineViewModel> GetExitEmployeeLeaveLines(int idExitEmployee, int period, int idLeaveType);

    }
}
