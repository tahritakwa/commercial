using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Reporting.Payroll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceSourceDeduction : IService<SourceDeductionViewModel, SourceDeduction>
    {
        ICollection<SourceDeductionViewModel> GenerateSourceDeduction(int id, int max, string userMail);
        SourceDeductionReportInformationsViewModel GetSourceDeductionInformations(int idSourceDeduction);
        EmployerDeclarationViewModel GetEmployerDeclarationHeader(int year);
        DataSourceResult<EmployerDeclarationLinesViewModel> GetEmployerDeclarationBody(PredicateFormatViewModel predicateFormatViewModel = null, int year = default);
        DownloadReportDataViewModel GetAllSourceDeductionReportSettings(int idSession, string userMail, out IList<SourceDeduction> sourceDeductions);
        DownloadReportDataViewModel GetSourceDeductionReportSettings(SourceDeduction sourceDeduction);
        void BrodcastSourceDeduction(string userMail, int idsession, string link, IDictionary<Employee, FileInfoViewModel> dictionary, SmtpSettings smtpSettings);
        void BrodcastOneSourceDeduction(string userMail, int id, string link, IDictionary<Employee, FileInfoViewModel> dictionary, SourceDeduction sourceDeduction, SmtpSettings smtpSettings);
    }
}
