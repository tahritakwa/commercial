using System.Collections.Generic;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;

namespace Services.Reporting.Interfaces
{
    public interface IPayRollServiceReporting
    {

        TransferOrderReportInformationsViewModel GetTransferOrderInformations(int idTransferOrder);
        IEnumerable<TransferOrderDetailsReportInformationsViewModel> GetTransferOrderDetails(int idTransferOrder);
        IEnumerable<SessionResumeLineViewModel> GetSessionResume(int idSession);
        SessionReportInformationsViewModel GetSessionInformations(int idSession);
        IList<CnssDeclarationLinesViewModel> GetCnssDeclarationLines(int idCnssDeclaration);
        CnssDeclarationInformationsViewModel GetCnssDeclaration(int idCnssDeclaration, out CnssDeclarationViewModel cnssDeclarationViewModel);
        CnssDeclarationSummaryViewModel GetCnssDeclarationSummary(int idCnssDeclaration);
        PayslipReportInformationsViewModel GetPayslipInformations(int idPaylsip);
        IList<PayslipReportLinesViewModel> GetPayslipReportInformationLines(int idPaylsip);
        IList<ReportDetailDateLineViewModel> GetExitEmployeePayInformations(int idExitEmployee);
        ExitEmployeeInformationsViewModel GetExitEmployeeInformations(int idExitEmploye);
    }
}
