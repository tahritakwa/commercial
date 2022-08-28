using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceLoan : Service<LoanViewModel, Loan>, IServiceLoan
    {
        private readonly IRepository<Contract> _contractRepository;
        private readonly IRepository<LoanInstallment> _loanInstallmentRepository;
        private readonly IServicePayslip _servicePayslip;
        public ServiceLoan(
           IRepository<Loan> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IUnitOfWork unitOfWork,
           ILoanBuilder builder,
           IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
           IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<Contract> contractRepository,
           IServicePayslip servicePayslip, IRepository<LoanInstallment> loanInstallmentRepository) :
            base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _contractRepository = contractRepository;
            _servicePayslip = servicePayslip;
            _loanInstallmentRepository = loanInstallmentRepository;
        }

        public override object AddModelWithoutTransaction(LoanViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList,
            string userMail, string property = null)
        {
            CheckLoanValidity(model);
            var contract = _contractRepository.FindByAsNoTracking(x => x.IdEmployee == model.IdEmployee &&
                ((x.EndDate.HasValue && model.ObtainingDate.BetweenDateLimitIncluded(x.StartDate, x.EndDate.Value))
                || (!x.EndDate.HasValue && model.ObtainingDate.AfterDateLimitIncluded(x.StartDate))));
            if (contract == null || !contract.Any())
            {
                throw new CustomException(CustomStatusCode.EmployeeWithoutContract);
            }
            else
            {
                VerifyNetToPay(model, contract.FirstOrDefault().Id);
                model.State = (int)AdministrativeDocumentStatusEnumerator.Waiting;
                // Manage leave attachement file
                ManageLoanAttachementFile(model);
                return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            }
        }

        public override object UpdateModelWithoutTransaction(LoanViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            var result = new Object();
            if (model.State == (int)AdministrativeDocumentStatusEnumerator.Accepted)
            {
                CheckLoanValidity(model);
                Contract contract = _contractRepository.GetSingleNotTracked(x => x.IdEmployee == model.IdEmployee && model.ObtainingDate.AfterDateLimitIncluded(x.StartDate) && model.RefundStartDate.HasValue &&
                  ((x.EndDate.HasValue && model.RefundStartDate.Value.BetweenDateLimitIncluded(x.StartDate, x.EndDate.Value) &&
                     new DateTime(model.RefundStartDate.Value.Year + (model.RefundStartDate.Value.Month + model.MonthsNumber) / NumberConstant.Twelve,
                       model.RefundStartDate.Value.Month < NumberConstant.Twelve ? (model.RefundStartDate.Value.Month + model.MonthsNumber - 1) % NumberConstant.Twelve : NumberConstant.One,
                       model.RefundStartDate.Value.Day).BeforeDateLimitIncluded(x.EndDate.Value))
                   || (!x.EndDate.HasValue && model.RefundStartDate.Value.AfterDateLimitIncluded(x.StartDate))));
                if (contract == null)
                {
                    throw new CustomException(CustomStatusCode.EmployeeWithoutContract);
                }
                else
                {
                    VerifyNetToPay(model, contract.Id);
                    // Manage leave attachement file
                    ManageLoanAttachementFile(model);
                }
            }
            result = base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            return result;
        }

        /// <summary>
        /// Validate loan request
        /// </summary>
        /// <param name="loanViewModel"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="smtpSettings"></param>
        public void ValidateRequest(LoanViewModel loanViewModel, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, SmtpSettings smtpSettings)
        {
            CheckLoanValidity(loanViewModel);
            if (loanViewModel.State == (int)AdministrativeDocumentStatusEnumerator.Accepted)
            {
                double installmentAmount = loanViewModel.Amount / loanViewModel.MonthsNumber;
                double roundedInstallment = _servicePayslip.PayrollRound(installmentAmount);
                loanViewModel.LoanInstallment = new List<LoanInstallmentViewModel>();
                for (int index = NumberConstant.Zero; index < loanViewModel.MonthsNumber; index++)
                {
                    LoanInstallmentViewModel loanInstallmentViewModel = new LoanInstallmentViewModel
                    {
                        Month = loanViewModel.RefundStartDate.Value.FirstDateOfMonth().AddMonths(index),
                        State = (int)LoanInstallmentEnumerator.Unpaid
                    };
                    loanInstallmentViewModel.Amount = (index != loanViewModel.MonthsNumber - 1) ?
                        roundedInstallment :
                        _servicePayslip.PayrollRound(loanViewModel.Amount - loanViewModel.LoanInstallment.Sum(x => x.Amount));
                    loanViewModel.LoanInstallment.Add(loanInstallmentViewModel);
                }
            }
            UpdateModelWithoutTransaction(loanViewModel, entityAxisValuesModelList, userMail);
        }

        /// <summary>
        /// Check if loan is negative and if there is already a loan in the chosen month
        /// </summary>
        /// <param name="loan"></param>
        private void CheckLoanValidity(LoanViewModel loan)
        {
            if (loan.MonthsNumber != NumberConstant.Zero)
            {
                if (loan.CreditType == (int)CreditEnumerator.Advance && loan.MonthsNumber != NumberConstant.One)
                {
                    throw new CustomException(CustomStatusCode.MonthNumberOverrun);
                }
            }
            if (loan.Amount <= NumberConstant.Zero)
            {
                throw new CustomException(CustomStatusCode.NegativeLoanAmount);
            }
            // Force the day of the month of the RefundStartDate to first day of month
            if (loan.RefundStartDate.HasValue)
            {
                loan.RefundStartDate = loan.RefundStartDate.Value.FirstDateOfMonth();
            }

        }

        /// <summary>
        /// Check if the amount exceeds the maximum limit or not
        /// </summary>
        /// <param name="model"></param>
        /// <param name="contractId"></param>
        private void VerifyNetToPay(LoanViewModel model, int contractId)
        {
            if (model.CreditType == (int)CreditEnumerator.Advance || model.State == (int)AdministrativeDocumentStatusEnumerator.Accepted)
            {
                PayslipReportInformationsViewModel payslipReportInformationsViewModel = GeneratePayslipInformations(model, contractId);
                if (payslipReportInformationsViewModel.NetToPay < model.Amount && model.CreditType == (int)CreditEnumerator.Advance)
                {
                    IDictionary<string, dynamic> parameters = new Dictionary<string, dynamic>
                    {
                        {PayRollConstant.NetToPay, payslipReportInformationsViewModel.NetToPay}
                    };
                    throw new CustomException(CustomStatusCode.LoanExceedsLimit, parameters);
                }
                else if (model.State == (int)AdministrativeDocumentStatusEnumerator.Accepted && model.LoanInstallment.Any(x => payslipReportInformationsViewModel.NetToPay < x.Amount))
                {
                    throw new CustomException(CustomStatusCode.NegativeSalary);
                }
            }
            else if (model.Amount > NumberConstant.OneMillion)
            {
                throw new CustomException(CustomStatusCode.LoanExceedsLimit);
            }
        }

        /// <summary>
        /// Generate payslip informations
        /// </summary>
        /// <param name="model"></param>
        /// <param name="contractId"></param>
        /// <returns></returns>
        private PayslipReportInformationsViewModel GeneratePayslipInformations(LoanViewModel model, int contractId)
        {
            PayslipViewModel payslipViewModel = new PayslipViewModel
            {
                Id = NumberConstant.Zero,
                NumberDaysWorked = NumberConstant.TwentySix,
                NumberDaysPaidLeave = NumberConstant.Zero,
                IdEmployee = model.IdEmployee,
                IdContract = contractId,
                Month = model.RefundStartDate.HasValue ? model.RefundStartDate.Value.FirstDateOfMonth() : model.ObtainingDate.FirstDateOfMonth()
            };
            return _servicePayslip.GetPayslipPreviewInformation(payslipViewModel);
        }

        /// <summary>
        /// Get net to pay
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public double GetNetToPay(LoanViewModel model)
        {
            var contract = _contractRepository.FindByAsNoTracking(x => x.IdEmployee == model.IdEmployee &&
               ((x.EndDate.HasValue && model.ObtainingDate.BetweenDateLimitIncluded(x.StartDate, x.EndDate.Value))
               || (!x.EndDate.HasValue && model.ObtainingDate.AfterDateLimitIncluded(x.StartDate))));
            if (contract == null || !contract.Any())
            {
                throw new CustomException(CustomStatusCode.EmployeeWithoutContract);
            }
            PayslipReportInformationsViewModel payslipReportInformationsViewModel = GeneratePayslipInformations(model, contract.FirstOrDefault().Id);
            double loanInstallmentsToPay = _loanInstallmentRepository.FindByAsNoTracking(x => x.IdLoanNavigation.IdEmployee == model.IdEmployee && x.IdLoan != model.Id
                && x.Month.EqualsDate(model.ObtainingDate.FirstDateOfMonth())).Sum(x => x.Amount);
            double maximum = payslipReportInformationsViewModel.NetToPay - loanInstallmentsToPay;
            // If maximum is equal to zero or negative, it will return -1
            // 0 in front is read as undefined
            return maximum > NumberConstant.Zero ? maximum : NumberConstant.MinusOne;
        }
        /// <summary>
        /// Manage Loan file attachement
        /// </summary>
        /// <param name="loanViewModel"></param>
        private void ManageLoanAttachementFile(LoanViewModel loanViewModel)
        {
            if (string.IsNullOrEmpty(loanViewModel.LoanAttachementFile))
            {
                if (loanViewModel.LoanFileInfo != null && loanViewModel.LoanFileInfo.Count != NumberConstant.Zero)
                {
                    loanViewModel.LoanAttachementFile = Path.Combine(PayRollConstant.PayRollFileRootPath + PayRollConstant.Loan + loanViewModel.Id, Guid.NewGuid().ToString());
                    CopyFiles(loanViewModel.LoanAttachementFile, loanViewModel.LoanFileInfo);
                }
            }
            else
            {
                if (loanViewModel.LoanFileInfo != null)
                {
                    DeleteFiles(loanViewModel.LoanAttachementFile, loanViewModel.LoanFileInfo);
                    CopyFiles(loanViewModel.LoanAttachementFile, loanViewModel.LoanFileInfo);
                }
            }
        }

        public override LoanViewModel GetModelById(int id)
        {
            LoanViewModel loanRequest = base.GetModelAsNoTracked(x => x.Id == id, x => x.IdEmployeeNavigation);
            if (loanRequest != null)
            {
                loanRequest.LoanFileInfo = GetFiles(loanRequest.LoanAttachementFile).ToList();
            }
            return loanRequest;
        }
    }
}
