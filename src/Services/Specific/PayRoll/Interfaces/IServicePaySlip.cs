using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Models;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Generic;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServicePayslip : IService<PayslipViewModel, Payslip>
    {
        PayslipViewModel AddModelPayslip(PayslipViewModel model, double daysOfWork, bool dependOnTimeSheet);
        ICollection<SalaryRuleViewModel> GetRulesAndValues(PayslipViewModel model, SalaryStructureViewModel IdSalaryStructure, double? daysOfWork, bool? dependOnTimeSheet);
        ICollection<SalaryRuleViewModel> GetEmployeeContractRules(PayslipViewModel model, double? daysOfWork, bool? dependOnTimeSheet);
        DownloadReportDataViewModel GetAllPayslipReportSettings(int idSession, string userMail, out IList<Payslip> payslips);
        DownloadReportDataViewModel GetPayslipReportSettings(Payslip payslip);
        PayslipReportInformationsViewModel GetPayslipPreviewInformation(PayslipViewModel payslipViewModel);
        ICollection<PayslipViewModel> GeneratePayslip(int id, int max, string userMail);
        FileInfoViewModel GetFileInfoForDownload(FileInfoViewModel fileInfoViewModel);
        PayslipReportInformationsViewModel GetPayslipReportInformation(int idPaylsip);
        IList<PayslipReportLinesViewModel> GetPayslipReportInformationLines(int idPaylsip);
        void BrodcastPayslip(string userMail, int idsession, string link, IDictionary<Contract, FileInfoViewModel> dictionary, SmtpSettings smtpSettings);
        DataSourceResult<PayslipViewModel> GetPayslipHistory(PredicateFormatViewModel predicate, DateTime startDate, DateTime endDate);
        DownloadReportDataViewModel GetAllPayslipOfSelectedEmployeeReportSettings(PredicateFormatViewModel predicate, DateTime startDate, DateTime endDate);
        double PayrollRound(double valueToRound);
        void BrodcastOnePayslip(string userMail, string link, IDictionary<Contract, FileInfoViewModel> dictionary , Payslip payslip, SmtpSettings smtpSettings);
        void UpdateSourceDeductions(List<PayslipViewModel> payslips, int year, bool sessionToDelete = false);
        bool CheckIfThereAreSourceDeductionsToDelete(int idSession);
    }
}
