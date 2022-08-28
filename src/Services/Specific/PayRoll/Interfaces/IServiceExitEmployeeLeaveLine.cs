using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting.Generic;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceExitEmployeeLeaveLine : IService<ExitEmployeeLeaveLineViewModel, ExitEmployeeLeaveLine>
    {
        void GenerateLeaveBalanceForExitEmployee(int idExitEmployee);
        DataSourceResult<ExitEmployeeLeaveLineViewModel> GetListOfLeave(PredicateFormatViewModel predicate);
        DownloadReportDataViewModel GetAllLeaveResumeReportSettings(int idExitEmployee, string userMail, out IList<ExitEmployeeLeaveLine> exitEmployeeLeaveLines);
    
    }
}
