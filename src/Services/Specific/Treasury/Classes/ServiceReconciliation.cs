using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using Services.Specific.Treasury.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Treasury.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.Treasury;
using ViewModels.DTO.Utils;

namespace Services.Specific.Treasury.Classes
{
    public class ServiceReconciliation : Service<ReconciliationViewModel, Reconciliation>, IServiceReconciliation
    {
        private const string Module = "Treasury";
        private const string Directory = "Reconciliation";
        private readonly IRepository<Settlement> _repoSettlement;
        private readonly IServiceCompany _serviceCompany;
        private readonly IRepository<BankAccount> _repositoryBankAccount;
        public ServiceReconciliation(IRepository<Reconciliation> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork,            IReconciliationBuilder builder,
            IRepository<User> entityRepoUser,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IOptions<AppSettings> appSettings,
            IRepository<Company> entityRepoCompany,
            IRepository<Settlement> repoSettlement,
            IRepository<BankAccount> repositoryBankAccount,
            IServiceCompany serviceCompany)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _repoSettlement = repoSettlement;
            _repositoryBankAccount = repositoryBankAccount;
            _serviceCompany = serviceCompany;
        }


        /// <summary>
        /// Add new reconciliation and updates the settlements
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userMail"></param>
        public void CashSettlements(ReconciliationViewModel model, List<int> settlementIds, string userMail)
        {

            try
            {
                BeginTransaction();
                if (model == null)
                {
                    throw new Exception();
                }
                if (settlementIds == null || !settlementIds.Any())
                {
                    throw new Exception();
                }
                ManageFiles(model);

                // Get settlement to cash
                List<Settlement> settlementModels = _repoSettlement.GetAllWithConditionsRelationsAsNoTracking(x => settlementIds.Contains(x.Id), r => r.IdTiersNavigation).ToList();

                // Add reconciliation model
                CurrencyViewModel currentCompany = _serviceCompany.GetCurrentCompany().IdCurrencyNavigation;

                double debit = Math.Round(settlementModels.Where(p => p.IdTiersNavigation.IdTypeTiers == (int)TiersType.Supplier)
                                                .Sum(x => x.Amount.Value), currentCompany.Precision);

                double credit = Math.Round(settlementModels.Where(p => p.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer)
                                                .Sum(x => x.Amount.Value), currentCompany.Precision);

                model.TotalCredit = debit;
                model.TotalDebit = credit;
                model.Settlement = null;
                int idReconciliation = ((CreatedDataViewModel)base.AddModelWithoutTransaction(model, null, userMail)).Id;

                // Update the bankAccount
                BankAccount bankAccount = _repositoryBankAccount.GetAllWithConditionsRelationsAsNoTracking(x => x.Id == model.IdBankAccount).FirstOrDefault();
                bankAccount.CurrentBalance = bankAccount != null ? Math.Round(bankAccount.CurrentBalance + credit - debit, currentCompany.Precision) : NumberConstant.Zero;
                _repositoryBankAccount.Update(bankAccount);

                // Update the settlement 
                settlementModels.ForEach((settlement) =>
                {
                    settlement.IdReconciliation = idReconciliation;
                    settlement.IdBankAccount = model.IdBankAccount;
                    settlement.IdPaymentStatus = (int)PaymentStatusEnumerators.Cashed;
                    settlement.IdTiersNavigation = null;
                });
                _repoSettlement.BulkUpdate(settlementModels);
                _unitOfWork.Commit();
                EndTransaction();
            }
            catch (Exception)
            {
                RollBackTransaction();
                throw;
            } 

        }

        private void ManageFiles(ReconciliationViewModel model)
        {
            if (string.IsNullOrEmpty(model.AttachmentUrl))
            {
                if (model.ObservationsFilesInfo != null && model.ObservationsFilesInfo.Count > 0)
                {
                    model.AttachmentUrl = Path.Combine(Module, Directory, DateTime.UtcNow.ToString("yyyyMMddHHmmssfffffff", CultureInfo.InvariantCulture));
                    CopyFiles(model.AttachmentUrl, model.ObservationsFilesInfo);
                }
            }
            else
            {
                if (model.ObservationsFilesInfo != null)
                {
                    DeleteFiles(model.AttachmentUrl, model.ObservationsFilesInfo);
                    CopyFiles(model.AttachmentUrl, model.ObservationsFilesInfo);
                }
            }
        }

    }
}
