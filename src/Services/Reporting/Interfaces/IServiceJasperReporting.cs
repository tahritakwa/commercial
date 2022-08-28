using Persistence.Entities;
using Settings.Config;
using System.Collections.Generic;
using System.Threading.Tasks;
using Utils.Utilities.ReportUtilities;
using ViewModels.DTO.Models;
using ViewModels.DTO.Reporting.Generic;

namespace Services.Reporting.Interfaces
{
    public interface IServiceJasperReporting
    {
        Task<FileInfoViewModel> ExecuteJasperReport(DownloadReportDataViewModel data, string userMail);
        Task<FileInfoViewModel> ExecuteMultipleJasperReport(DownloadReportDataViewModel data, string userMail);
        Task<byte[]> ExecuteAndDownloadReportByte(ResourceLookup reportResource, string reportFormat, dynamic reportParams, DownloadReportDataViewModel data = null);
        Task ExecuteJaspertReportAsync(ResourceLookup reportResource, string reportFormat, dynamic reportParams);
        Task SetJaspertReportParamsAsync(ResourceLookup reportResource, string reportFormat, dynamic reportParams);
        Task SetJaspertReportParamsInputControlAsync(ResourceLookup reportResource, string reportFormat, dynamic reportParams);
        Task<FileInfoViewModel> ExportJasperReportDocument();
        Task<FileInfoViewModel> DownloadJasperReportDocument(DownloadReportDataViewModel data);
        Task<ResourceLookup> GetReportLookUp(string reportName);
        Task<JasperReportingResources> GetReportInfo(string reportName);
        void InitClient();
        void SetClientAuthentication(string username = "jasperadmin", string password = "jasperadmin");
        void SetAsyncExecution(bool asyncRun);
        void SetOutputFormat(string outputFormat);
        void AddParameter(ReportParameter reportParam);
        void SetParameter(List<ReportParameter> reportParam);
        void RemoveParameter(ReportParameter reportParam);
        Task<FileInfoViewModel> MassiveDownLoad(DownloadReportDataViewModel downloadReportDataViewModel, string userMail);
        Task<Dictionary<Contract, FileInfoViewModel>> GetPayslipReports(DownloadReportDataViewModel downloadReportDataViewModel, IList<Payslip> payslips, string userMail);
        Task<Dictionary<Employee, FileInfoViewModel>> GetSourceDeductionReports(DownloadReportDataViewModel downloadReportDataViewModel, IList<SourceDeduction> sourceDeduction, string userMail);
        Task<FileInfoViewModel> ExecuteMultipleVatDeclarationReport(DownloadReportDataViewModel data, string userMail);
    }
}
