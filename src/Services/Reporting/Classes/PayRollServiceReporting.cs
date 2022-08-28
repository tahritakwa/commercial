using Microsoft.EntityFrameworkCore;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Services.Reporting.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Utils.Constants.PayrollConstants;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Generic;

namespace Services.Reporting.Classes
{
    /// <summary>
    /// This service provide informations for Telerik report
    /// </summary>
    public class PayRollServiceReporting : IPayRollServiceReporting
    {
        #region Fields
        private readonly IServiceCompany _serviceCompany;
        private readonly IRepository<TransferOrder> _repositoryTransferOrder;
        private readonly IServiceSession _serviceSession;
        private readonly IServiceCnssDeclaration _serviceCnssDeclaration;
        private readonly IServiceCnssDeclarationDetails _serviceCnssDeclarationDetails;
        private readonly IServicePayslip _servicePayslip;
        private readonly IRepository<ExitEmployeePayLine> _entityExitEmployeePayLine;
        private readonly IRepository<ExitEmployee> _entityExitEmployee;

        #endregion
        #region Constructor
        public PayRollServiceReporting(IRepository<TransferOrder> repositoryTransferOrder,
             IServiceCompany serviceCompany,
            IServiceSession serviceSession, IServiceCnssDeclaration serviceCnssDeclaration,
            IServiceCnssDeclarationDetails serviceCnssDeclarationDetails, IServicePayslip servicePayslip,
            IRepository<ExitEmployeePayLine> entityExitEmployeePayLine,
            IRepository<ExitEmployee> entityExitEmployee)
        {
            _repositoryTransferOrder = repositoryTransferOrder;
            _serviceCompany = serviceCompany;
            _serviceSession = serviceSession;
            _serviceCnssDeclaration = serviceCnssDeclaration;
            _serviceCnssDeclarationDetails = serviceCnssDeclarationDetails;
            _servicePayslip = servicePayslip;
            _entityExitEmployeePayLine = entityExitEmployeePayLine;
            _entityExitEmployee = entityExitEmployee;
        }
        #endregion
        #region Methodes
        /// <summary>
        /// Get transfer order informations
        /// </summary>
        /// <param name="idTransferOrder"></param>
        /// <param name="idCompany"></param>
        /// <returns></returns>
        public TransferOrderReportInformationsViewModel GetTransferOrderInformations(int idTransferOrder)
        {
  
            // Get report company information
            ReportCompanyInformationViewModel reportCompanyInformationViewModel = _serviceCompany.GetReportCompanyInformation();

            // Get current transfer order with bank account navigation
            TransferOrder transferOrder = _repositoryTransferOrder.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == idTransferOrder)
               .Include(x => x.IdBankAccountNavigation).ThenInclude(y => y.IdBankNavigation).FirstOrDefault();
            // Build report informations
            TransferOrderReportInformationsViewModel transfer = new TransferOrderReportInformationsViewModel(reportCompanyInformationViewModel)
            {
                Date = transferOrder.CreationDate,
                Label = transferOrder.Title ?? string.Empty,
                Total = transferOrder.TotalAmount,
                RibCompany = transferOrder.IdBankAccountNavigation.Rib ?? string.Empty,
                SessionMonth = transferOrder.Month != null ? transferOrder.Month.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language) : string.Empty,
                BankName = transferOrder.IdBankAccountNavigation.IdBankNavigation.Name ?? string.Empty
            };
            return transfer;
        }

        /// <summary>
        /// Get the details of the tranbsfer order with the id in parameter
        /// </summary>
        /// <param name="idTransferOrder"></param>
        /// <returns></returns>
        public IEnumerable<TransferOrderDetailsReportInformationsViewModel> GetTransferOrderDetails(int idTransferOrder)
        {
            TransferOrder transferOrder = _repositoryTransferOrder.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == idTransferOrder)
                .Include(x => x.TransferOrderDetails).ThenInclude(x => x.IdEmployeeNavigation).FirstOrDefault();
            IList<TransferOrderDetailsReportInformationsViewModel> details = new List<TransferOrderDetailsReportInformationsViewModel>();
            transferOrder.TransferOrderDetails.ToList().ForEach(x =>
            {
                details.Add(new TransferOrderDetailsReportInformationsViewModel
                {
                    EmployeeFullName = x.IdEmployeeNavigation != null && !string.IsNullOrEmpty(x.IdEmployeeNavigation.FullName) ? x.IdEmployeeNavigation.FullName : string.Empty,
                    Amount = x.Amount,
                    Label = PayRollConstant.TransferOrderSalary + PayRollConstant.Separator + transferOrder.Month.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language),
                    Rib = x.Rib ?? string.Empty
                });
            });
            return details;
        }

        /// <summary>
        /// Get resume lines for the reporting
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public IEnumerable<SessionResumeLineViewModel> GetSessionResume(int idSession)
        {
            return _serviceSession.GetSessionResumeReportLines(idSession);
        }

        /// <summary>
        /// Get session informations
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns></returns>
        public SessionReportInformationsViewModel GetSessionInformations(int idSession)
        {
            // Get report company information
            ReportCompanyInformationViewModel reportCompanyInformationViewModel = _serviceCompany.GetReportCompanyInformation();
            SessionReportInformationsViewModel sessionReportInformations = new SessionReportInformationsViewModel(reportCompanyInformationViewModel);
            sessionReportInformations.Rib = string.Empty;
            sessionReportInformations.BankName = string.Empty;
            // Get session by id
            SessionViewModel sessionViewModel = _serviceSession.GetModelById(idSession);
            if (sessionViewModel != null)
            {
                sessionReportInformations.Code = sessionViewModel.Code;
                sessionReportInformations.Title = sessionViewModel.Title;
                sessionReportInformations.Month = sessionViewModel.Month.ToString("MMMM", CultureInfo.CreateSpecificCulture("fr-FR"));
                sessionReportInformations.Year = sessionViewModel.Month.Year.ToString();
            }
            // return report informations
            return sessionReportInformations;
        }


        /// <summary>
        /// Get the specific Cnss declaration lines
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        public IList<CnssDeclarationLinesViewModel> GetCnssDeclarationLines(int idCnssDeclaration)
        {
            return _serviceCnssDeclarationDetails.GetCnssDeclarationLines(idCnssDeclaration);
        }

        /// <summary>
        /// Get the Cnss declaration informations
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        public CnssDeclarationInformationsViewModel GetCnssDeclaration(int idCnssDeclaration, out CnssDeclarationViewModel cnssDeclarationViewModel)
        {
            return _serviceCnssDeclaration.GetCnssDeclaration(idCnssDeclaration, out cnssDeclarationViewModel);
        }

        /// <summary>
        /// Calculate Cnss declaration Summary
        /// </summary>
        /// <param name="idCnssDeclaration"></param>
        /// <returns></returns>
        public CnssDeclarationSummaryViewModel GetCnssDeclarationSummary(int idCnssDeclaration)
        {
            CnssDeclarationSummaryViewModel model = new CnssDeclarationSummaryViewModel
            {
                CnssDeclarationInformationsViewModel = _serviceCnssDeclaration.GetCnssDeclaration(idCnssDeclaration, out CnssDeclarationViewModel cnssDeclarationViewModel),
                SocialSecurityRate = cnssDeclarationViewModel.IdCnssNavigation.SalaryRate + cnssDeclarationViewModel.IdCnssNavigation.EmployerRate,
                WorkAccidentRate = cnssDeclarationViewModel.IdCnssNavigation.WorkAccidentQuota
            };
            model.SocialSecurityAmount = Math.Round(model.CnssDeclarationInformationsViewModel.TotalAmount * model.SocialSecurityRate / 100, 3);
            model.WorkAccidentAmount = Math.Round(model.CnssDeclarationInformationsViewModel.TotalAmount * model.WorkAccidentRate / 100, 3);
            model.Total = Math.Round(model.SocialSecurityAmount + model.WorkAccidentAmount, 3);
            model.AmountToBePaid = Math.Round(model.Total + model.AmountOfLatePenalties, 3);
            return model;
        }

        /// <summary>
        /// Get the payslip information
        /// </summary>
        /// <param name="idPaylsip"></param>
        /// <returns></returns>
        public PayslipReportInformationsViewModel GetPayslipInformations(int idPaylsip)
        {
            return _servicePayslip.GetPayslipReportInformation(idPaylsip);
        }

        /// <summary>
        /// Get the payslip lines
        /// </summary>
        /// <param name="idPaylsip"></param>
        /// <returns></returns>
        public IList<PayslipReportLinesViewModel> GetPayslipReportInformationLines(int idPaylsip)
        {
            return _servicePayslip.GetPayslipReportInformationLines(idPaylsip);
        }

        /// <summary>
        /// get the pay lines of exit employee
        /// </summary>
        /// <param name="idExitEmployee"></param>
        /// <returns></returns>
        public IList<ReportDetailDateLineViewModel> GetExitEmployeePayInformations(int idExitEmployee)
        {
            var cultureInfo = (NumberFormatInfo)CultureInfo.InvariantCulture.NumberFormat.Clone();
            cultureInfo.NumberGroupSeparator = " ";
            List<ReportDetailDateLineViewModel> reportDetailDateLineViewModels = new List<ReportDetailDateLineViewModel>();
            IList<ExitEmployeePayLine> employeePayLines = _entityExitEmployeePayLine.GetAllAsNoTracking().Where(x => x.IdExitEmployee == idExitEmployee)
                .Include(x => x.ExitEmployeePayLineSalaryRule)
                .ThenInclude(x => x.IdSalaryRuleNavigation)
                .ThenInclude(x => x.IdRuleUniqueReferenceNavigation)
                .ToList();
            foreach (ExitEmployeePayLine exitEmployeePayLinel in employeePayLines)
            {
                reportDetailDateLineViewModels.Add(new ReportDetailDateLineViewModel
                {
                    Month = exitEmployeePayLinel.Month,
                    Details = exitEmployeePayLinel.Details != null ? exitEmployeePayLinel.Details : string.Empty,
                    BaseSalary = exitEmployeePayLinel.ExitEmployeePayLineSalaryRule.Where(x => x.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference == PayRollConstant.Base).FirstOrDefault().Value.ToString(),
                    GrossSalary = exitEmployeePayLinel.ExitEmployeePayLineSalaryRule.Where(x => x.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference == PayRollConstant.Brut).FirstOrDefault().Value.ToString(),
                    SocialContribution = exitEmployeePayLinel.ExitEmployeePayLineSalaryRule.Where(x => x.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference == PayRollConstant.Cnss).FirstOrDefault().Value.ToString(),
                    TaxableWages = exitEmployeePayLinel.ExitEmployeePayLineSalaryRule.Where(x => x.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference == PayRollConstant.Net).FirstOrDefault().Value.ToString(),
                    Irpp = exitEmployeePayLinel.ExitEmployeePayLineSalaryRule.Where(x => x.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference == PayRollConstant.Irpp).FirstOrDefault().Value.ToString(),
                    Css = exitEmployeePayLinel.ExitEmployeePayLineSalaryRule.Where(x => x.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference == PayRollConstant.Css).FirstOrDefault().Value.ToString(),
                    NetSalary = exitEmployeePayLinel.ExitEmployeePayLineSalaryRule.Where(x => x.IdSalaryRuleNavigation.IdRuleUniqueReferenceNavigation.Reference == PayRollConstant.Netapayer).FirstOrDefault().Value.ToString(),

                }) ;
            }
            reportDetailDateLineViewModels.ForEach(e => e.MonthString = e.Month.Format(DateFormat.YearMonthDateFormat, ActiveAccountHelper.GetConnectedUserCredential().Language));
            return reportDetailDateLineViewModels;
        }
        /// <summary>
        /// get the informations of exit employee
        /// </summary>
        /// <param name="idExitEmployee"></param>
        /// <returns></returns>
        public ExitEmployeeInformationsViewModel GetExitEmployeeInformations (int idExitEmployee)
        {
            // Get report company information
            ReportCompanyInformationViewModel reportCompanyInformationViewModel = _serviceCompany.GetReportCompanyInformation();
            ExitEmployee exitEmployee = _entityExitEmployee.GetSingleWithRelations(x => x.Id == idExitEmployee, x => x.IdEmployeeNavigation);
            ExitEmployeeInformationsViewModel reportDetailDateLineViewModel = new ExitEmployeeInformationsViewModel(reportCompanyInformationViewModel)
            {
                EmployeeFullName = exitEmployee.IdEmployeeNavigation.FullName,
                Email = exitEmployee.IdEmployeeNavigation.Email,
                ExitPhysicalDate = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(new DateTime(exitEmployee.ExitPhysicalDate.Value.Year, exitEmployee.ExitPhysicalDate.Value.Month,
                exitEmployee.ExitPhysicalDate.Value.Day).ToString("dd/MM/yyyy", CultureInfo.CreateSpecificCulture("fr-FR"))),
                HiringDate = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(exitEmployee.IdEmployeeNavigation.HiringDate.ToString("dd/MM/yyyy", CultureInfo.CreateSpecificCulture("fr-FR"))),
                CompanyLogo = _serviceCompany.GetReportCompanyInformation().CompanyLogo,
                Rib = string.Empty,
                BankName = string.Empty
            };

            return reportDetailDateLineViewModel;

        }
        #endregion
    }
}
