using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Payment.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Utils;

namespace Services.Specific.Payment.Classes
{
    public class ServicePaymentSlip : Service<PaymentSlipViewModel, PaymentSlip>, IServicePaymentSlip
    {
        internal readonly IServiceSettlement _serviceSettlement;
        internal readonly IRepository<Settlement> _repoSettlement;
        internal readonly IServiceBank _serviceBank;
        internal readonly IReducedPaymentSlipBuilder _reducedBuilder;

        public ServicePaymentSlip(
               IRepository<PaymentSlip> entityRepo,
               IUnitOfWork unitOfWork,
               IPaymentSlipBuilder builder,
               IRepository<EntityAxisValues> entityRepoEntityAxisValues,
               IEntityAxisValuesBuilder builderEntityAxisValues,
               IOptions<AppSettings> appSettings,
               IRepository<Company> entityRepoCompany,
               IServiceSettlement serviceSettlement,
               IServiceBank serviceBank,
               IRepository<Settlement> repoSettlement,
               IReducedPaymentSlipBuilder reducedBuilder)
           : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _serviceSettlement = serviceSettlement;
            _serviceBank = serviceBank;
            _repoSettlement = repoSettlement;
            _reducedBuilder = reducedBuilder;
        }


        public void AddPaymentSlip(PaymentSlipViewModel model, List<int> settlementIds, string userMail)
        {
            if (model == null)
            {
                throw new Exception();
            }
            if (settlementIds == null || !settlementIds.Any())
            {
                throw new CustomException(CustomStatusCode.NoSettlementFoundInPaymentSlip);
            }
            // Get associated settlements
            List<SettlementViewModel> settlementList = _serviceSettlement.FindByAsNoTracking(x => settlementIds.Contains(x.Id)).ToList();

            // Add payment slip
            Company company = _entityRepoCompany.GetAllWithRelations(x => x.IdCurrencyNavigation).FirstOrDefault();
            model.State = (int)PaymentSlipStatusEnumerator.Provisional;
            model.TotalAmountWithNumbers = Math.Round(settlementList.Sum(x => x.Amount.Value), company.IdCurrencyNavigation.Precision);
            model.TotalAmountWithLetters = HumanizerUtils.DecimalToWords(Convert.ToDecimal(model.TotalAmountWithNumbers.Value), company.Culture, company.IdCurrencyNavigation);
            model.Settlement = null;
            CreatedDataViewModel data = (CreatedDataViewModel)base.AddModelWithoutTransaction(model, null, userMail);

            // Update settlements
            settlementList.ForEach((settlement) =>
            {
                settlement.IdPaymentSlip = data.Id;
                settlement.IdBankAccount = model.IdBankAccount;
                settlement.IdPaymentStatus = (int)PaymentStatusEnumerators.RemittanceSlip;
            });

            _serviceSettlement.BulkUpdateModelWithoutTransaction(settlementList, userMail);

        }

        /// <summary>
        /// ValidatePaymentSlip
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        public void ValidatePaymentSlip(PaymentSlipViewModel model, List<int> settlementIds, string userMail)
        {
            try
            {
                BeginTransaction();
                if (model == null)
                {
                    throw new Exception();
                }
                if (settlementIds != null && !settlementIds.Any())
                {
                    throw new CustomException(CustomStatusCode.NoSettlementFoundInPaymentSlip);
                }

                List<int> newSettlementIds = new List<int>();
                List<int> deselectedSettlementIds = new List<int>();

                // Get all settlement of the payment slip
                List<Settlement> oldSettlementList = _repoSettlement.FindByAsNoTracking(x => x.IdPaymentSlip == model.Id).ToList();

                // When the paymentSlip state is provisoire the user can : 
                // -add new settlements or remove old settlements
                // -save or valid the payment slip 
                if ((model.State == (int)PaymentSlipStatusEnumerator.Provisional) || (model.State == (int)PaymentSlipStatusEnumerator.Valid))
                {
                    // Add the new selected settlements
                    newSettlementIds = settlementIds.Where(x => !oldSettlementList.Select(s => s.Id).Contains(x)).ToList();
                    if (newSettlementIds != null && newSettlementIds.Any())
                    {
                        IList<SettlementViewModel> newSettlements = _serviceSettlement.FindByAsNoTracking(x => newSettlementIds.Contains(x.Id)).ToList();
                        newSettlements.ToList().ForEach((m) =>
                        {
                            m.IdPaymentSlip = model.Id;
                            m.IdBankAccount = model.IdBankAccount;
                            m.IdPaymentStatus = (int)PaymentStatusEnumerators.RemittanceSlip;
                        });
                        _serviceSettlement.BulkUpdateModelWithoutTransaction(newSettlements, userMail);
                    }
                    // Update the deselected seltements
                    deselectedSettlementIds = oldSettlementList.Where(x => !settlementIds.Contains(x.Id)).Select(s => s.Id).ToList();
                    if (deselectedSettlementIds != null && deselectedSettlementIds.Any())
                    {
                        IList<Settlement> deselectedSettlements = _repoSettlement.FindByAsNoTracking(x => deselectedSettlementIds.Contains(x.Id)).ToList();
                        deselectedSettlements.ToList().ForEach((m) =>
                        {
                            m.IdPaymentSlip = null;
                            m.IdBankAccount = null;
                            m.IdPaymentStatus = (int)PaymentStatusEnumerators.Settled;
                        });
                        _serviceSettlement.BulkUpdateWithoutTransaction(deselectedSettlements);
                    }
                }

                // Get the old paymentSlip to prevent that the attributs can be modified only where the status is provisional
                PaymentSlipViewModel paymentSlipOld = GetModelAsNoTracked(x => x.Id == model.Id);
                if (paymentSlipOld.State == (int)PaymentSlipStatusEnumerator.Provisional)
                {
                    paymentSlipOld.Reference = model.Reference;
                    paymentSlipOld.Deposer = model.Deposer;
                    paymentSlipOld.Date = model.Date;
                    paymentSlipOld.IdBankAccount = model.IdBankAccount;
                    paymentSlipOld.Agency = model.Agency;
                }

                // Update paymentSlip
                paymentSlipOld.State = model.State;
                base.UpdateModelWithoutTransaction(paymentSlipOld, null, userMail);

                // Update the settlements
                List<int> settlementToUpdateIds = settlementIds.Where(x => oldSettlementList.Select(s => s.Id).Contains(x)).ToList();
                if (settlementToUpdateIds != null && settlementToUpdateIds.Any())
                {
                    IList<SettlementViewModel> settlementsToUpdate = _serviceSettlement.FindByAsNoTracking(x => settlementToUpdateIds.Contains(x.Id));
                    settlementsToUpdate.ToList().ForEach((settlement) =>
                    {
                        settlement.IdBankAccount = paymentSlipOld.IdBankAccount;
                        if (paymentSlipOld.State == (int)PaymentSlipStatusEnumerator.Valid)
                        {
                            settlement.IdPaymentStatus = (int)PaymentStatusEnumerators.RemittanceSlip;
                        }
                        else if (paymentSlipOld.State == (int)PaymentSlipStatusEnumerator.PaymentSlipIssued)
                        {
                            settlement.IdPaymentStatus = (int)PaymentStatusEnumerators.Issued;
                        }
                        else if (paymentSlipOld.State == (int)PaymentSlipStatusEnumerator.PaymentSlipBankFeedBack)
                        {
                            settlement.IdPaymentStatus = (int)PaymentStatusEnumerators.InBank;
                        }
                    });

                    _serviceSettlement.BulkUpdateModelWithoutTransaction(settlementsToUpdate, userMail);
                }
                EndTransaction();
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            }

        }


        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            PaymentSlipViewModel model = GetModelAsNoTracked(x => x.Id == id);
            if (model.State != (int)PaymentSlipStatusEnumerator.Provisional)
            {
                throw new CustomException(CustomStatusCode.deletePaymentSlipNotProvisionnal);
            }
            // change settlment status
            ICollection<SettlementViewModel> settlementList = _serviceSettlement.FindByAsNoTracking(x => x.IdPaymentSlip == id).ToList();
            foreach (SettlementViewModel settlement in settlementList)
            {
                settlement.IdPaymentStatus = (int)PaymentStatusEnumerators.Settled;
                settlement.IdPaymentSlip = null;
                settlement.IdBankAccount = null;
            }
            if (settlementList != null && settlementList.Any())
            {
                _serviceSettlement.BulkUpdateModelWithoutTransaction(settlementList.ToList(), userMail);
            }
            // delete the PaymentSlip
            return base.DeleteModelwithouTransaction(id, tableName, userMail);
        }

        /// <summary>
        /// GetPaymentSlip
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="predicateModel"></param>
        /// <returns></returns>
        public DataSourceResult<ReducedPaymentSlipViewModel> GetPaymentSlip(DateTime? startDate, DateTime? endDate, PredicateFormatViewModel predicateModel)
        {
            if (predicateModel == null)
            {
                throw new Exception();
            }

            PredicateFilterRelationViewModel<PaymentSlip> predicateFilterRelationModel = PreparePredicate(predicateModel);
            IQueryable<PaymentSlip> query = _entityRepo.GetAllAsNoTracking().Include(x => x.IdBankAccountNavigation)
                                                                           .ThenInclude(x => x.IdBankNavigation)
                                                                           .Where(predicateFilterRelationModel.PredicateWhere)
                                                                           .OrderByRelation(predicateModel.OrderBy);
            if (startDate != null)
            {
                query = query.Where(x => x.Date.Date.AfterDateLimitIncluded(startDate.Value.Date));
            }
            if (endDate != null)
            {
                query = query.Where(x => x.Date.Date.BeforeDateLimitIncluded(endDate.Value.Date));
            }

            DataSourceResult<ReducedPaymentSlipViewModel> paymentSlipWithTotal = new DataSourceResult<ReducedPaymentSlipViewModel>();


            paymentSlipWithTotal.total = query.Count();

            IQueryable<PaymentSlip> data = query.Skip((predicateModel.page - 1) * predicateModel.pageSize)
                                   .Take(predicateModel.pageSize);
            List<PaymentSlip> paymentSlips = data.ToList();

            paymentSlipWithTotal.data = paymentSlips.Select(_reducedBuilder.BuildEntity).ToList();

            return paymentSlipWithTotal;
        }

    }
}
