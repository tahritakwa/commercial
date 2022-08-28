using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.PayrollEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceLoanInstallment : Service<LoanInstallmentViewModel, LoanInstallment>, IServiceLoanInstallment
    {
        private readonly IServiceLoan _serviceLoan;
        private readonly IRepository<Contract> _contractRepository;
        public ServiceLoanInstallment(IRepository<LoanInstallment> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Contract> contractRepository, IUnitOfWork unitOfWork, ILoanInstallmentBuilder builder,
           IRepository<Entity> entityRepoEntity,
           IEntityAxisValuesBuilder builderEntityAxisValues, IServiceLoan serviceLoan)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceLoan = serviceLoan;
            _contractRepository = contractRepository;
        }
        public override object UpdateModelWithoutTransaction(LoanInstallmentViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList,
            string userMail, string property = null)
        {
            if (model.Amount < NumberConstant.Zero)
            {
                throw new CustomException(CustomStatusCode.NegativeLoanInstallment);
            }
            LoanViewModel loanViewModel = _serviceLoan.GetModelWithRelationsAsNoTracked(x => x.Id == model.IdLoan, y => y.LoanInstallment);
            Contract contract = _contractRepository.GetSingleNotTracked(x => x.IdEmployee == loanViewModel.IdEmployee && model.Month.AfterDateLimitIncluded(x.StartDate) &&
               ((x.EndDate.HasValue && model.Month.BetweenDateLimitIncluded(x.StartDate, x.EndDate.Value) &&
                  model.Month.BeforeDateLimitIncluded(x.EndDate.Value))
                || (!x.EndDate.HasValue && model.Month.AfterDateLimitIncluded(x.StartDate))));
            CheckLoanInstallmentWithContractEnd(model, contract);
            LoanInstallmentViewModel loanInstallmentBeforeUpdate = loanViewModel.LoanInstallment.Where(x => x.Id == model.Id).FirstOrDefault();
            double amount = Convert.ToDouble(Convert.ToDecimal(loanInstallmentBeforeUpdate.Amount - model.Amount));
            List<LoanInstallmentViewModel> loanInstallmentsToUpdate = new List<LoanInstallmentViewModel>();
            if (amount > NumberConstant.Zero)
            {
                IList<LoanInstallmentViewModel> loanInstallments = (List<LoanInstallmentViewModel>)loanViewModel.LoanInstallment;
                LoanInstallmentViewModel newLoanInstallment = new LoanInstallmentViewModel
                {
                    Id = NumberConstant.Zero,
                    State = (int)LoanInstallmentEnumerator.Unpaid,
                    Amount = amount,
                    IdLoan = model.IdLoan,
                    Month = loanInstallments.OrderByDescending(x => x.Month).FirstOrDefault().Month.AddMonths(NumberConstant.One),
                };
                CheckLoanInstallmentWithContractEnd(newLoanInstallment, contract);
                loanInstallmentsToUpdate.Add(newLoanInstallment);
            }
            else if (amount < NumberConstant.Zero)
            {
                if (loanViewModel.LoanInstallment.Count > NumberConstant.One)
                {
                    List<LoanInstallmentViewModel> restOfLoanInstallment = loanViewModel.LoanInstallment.Where(x => x.Id != model.Id && x.State == (int)LoanInstallmentEnumerator.Unpaid)
                        .OrderByDescending(x => x.Month).ToList();
                    while (amount < NumberConstant.Zero)
                    {
                        if (restOfLoanInstallment.Count == NumberConstant.Zero)
                        {
                            throw new CustomException(CustomStatusCode.LoanAmountExceeded);
                        }
                        LoanInstallmentViewModel loanInstallment = restOfLoanInstallment.FirstOrDefault();
                        restOfLoanInstallment.Remove(loanInstallment);
                        if (Convert.ToDecimal(loanInstallment.Amount + amount) >= NumberConstant.Zero)
                        {
                            loanInstallment.Amount = Convert.ToDouble(Convert.ToDecimal(loanInstallment.Amount + amount));
                            amount = NumberConstant.Zero;
                        }
                        else
                        {
                            amount = Convert.ToDouble(Convert.ToDecimal(loanInstallment.Amount + amount));
                            loanInstallment.Amount = NumberConstant.Zero;
                        }
                        loanInstallmentsToUpdate.Add(loanInstallment);
                    }
                }
                else
                {
                    throw new CustomException(CustomStatusCode.LoanAmountExceeded);
                }
            }
            loanInstallmentsToUpdate.Add(model);
            BulkUpdateModelWithoutTransaction(loanInstallmentsToUpdate, userMail);
            return new CreatedDataViewModel { Id = model.Id };
        }

        /// <summary>
        /// Check if month of loan installment exceeds contract end date
        /// </summary>
        /// <param name="loanInstallment"></param>
        /// <param name="contract"></param>
        private void CheckLoanInstallmentWithContractEnd(LoanInstallmentViewModel loanInstallment, Contract contract)
        {
            if (contract == null || (contract.EndDate.HasValue && loanInstallment.Month.AfterDateLimitIncluded(contract.EndDate.Value)))
            {
                throw new CustomException(CustomStatusCode.ForbidLoanInstallmentUpdate);
            }
        }

        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            LoanInstallmentViewModel loanInstallment = GetModelById(id);
            if (loanInstallment.Amount > NumberConstant.Zero)
            {
                throw new CustomException(CustomStatusCode.ForbidLoanInstallmentDeletion);
            }
            else
            {
                return base.DeleteModelwithouTransaction(id, tableName, userMail);
            }
        }
    }
}
