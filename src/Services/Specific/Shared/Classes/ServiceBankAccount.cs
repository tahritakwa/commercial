using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Classes
{
    public class ServiceBankAccount : Service<BankAccountViewModel, BankAccount>, IServiceBankAccount
    {
        private IServiceCompany _serviceCompany;
        private IServiceBankAgency _serviceBankAgency;
        internal readonly IRepository<User> _entityRepoUser;
        internal readonly IReducedBankAccountBuilder _reducedBuilder;
        internal readonly IReducedBankAccountDataBuilder _reducedDataBuilder;
        internal readonly IServiceBank _serviceBank;
        public ServiceBankAccount(IRepository<BankAccount> entityRepo, IUnitOfWork unitOfWork,
           IBankAccountBuilder bankAccountBuilder, IRepository<User> entityRepoUser, IServiceCompany serviceCompany,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues,
           IOptions<AppSettings> appSettings,
           IRepository<Company> entityRepoCompany,
           IReducedBankAccountBuilder reducedBuilder,
           IReducedBankAccountDataBuilder reducedDataBuilder,
           IServiceBank serviceBank,
           IServiceBankAgency serviceBankAgency
           )
             : base(entityRepo, unitOfWork, bankAccountBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany)
        {
            _entityRepoUser = entityRepoUser;
            _serviceCompany = serviceCompany;
            _reducedBuilder = reducedBuilder;
            _reducedDataBuilder = reducedDataBuilder;
            _serviceBankAgency = serviceBankAgency;
            _serviceBank = serviceBank;
        }

        public override object UpdateModelWithoutTransaction(BankAccountViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (model == null)
            {
                throw new Exception();
            }
            // Verify if the bank account is linked to settlements, paymentSlip or reconciliation
            BankAccountViewModel oldModel =  IsBankAccountLinked(model.Id);
            if (oldModel.IsLinked)
            {
                model.IdBank = oldModel.IdBank;
                model.Agency = oldModel.Agency;
                model.Code = oldModel.Code;
                model.Entitled = oldModel.Entitled;
                model.Rib = oldModel.Rib;
                model.Bic = oldModel.Bic;
                model.Iban = oldModel.Iban;
                model.IdCurrency = oldModel.IdCurrency;
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }
        public override object AddModel(BankAccountViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {

            try
            {
                BankViewModel bank = _serviceBank.GetModelAsNoTracked(x => x.Id == model.IdBank);
                model.IdCountry = bank.IdCountry;
                object obj = base.AddModel(model, entityAxisValuesModelList, userMail, null);
               
                return obj;
            }
            catch (CustomException)
            {
                // rollback transaction
                RollBackTransaction();
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }
        }

        public void AddBankAccountAssociatedToCompany(BankAccountViewModel model)
        {
            CompanyViewModel company = _serviceCompany.GetModel(x => true);
            base.AddModelWithoutTransaction(model, null, null, null);
        }

        public override DataSourceResult<BankAccountViewModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            DataSourceResult<BankAccountViewModel> result = base.FindDataSourceModelBy(predicateModel);
            if (result.data != null)
            {
                result.data.ToList().ForEach(x =>
                {
                    if (x.IdBankNavigation != null)
                    {
                        x.IdBankNavigation.LogoFileInfo = GetFilesContent(x.IdBankNavigation.AttachmentUrl).FirstOrDefault();
                    }
                });

            }
            return result;
        }

        public override DataSourceResult<dynamic> GetDataDropdownBy(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<BankAccount> predicateFilterRelationModel = PreparePredicate(predicateModel);
            List<BankAccount> entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).ToList();
            List<dynamic> model = entities.Select(x => _reducedBuilder.BuildEntity(x)).ToList<dynamic>();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<dynamic> { data = model, total = total };
        }

        public DataSourceResult<ReducedBankAccountDataViewModel> GetBankAccountList(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<BankAccount> predicateFilterRelationModel = PreparePredicate(predicateModel);

            List<BankAccount> entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).Skip((predicateModel.page - 1) * predicateModel.pageSize).
                    Take(predicateModel.pageSize).ToList();

            IList<ReducedBankAccountDataViewModel> model = entities.Select(_reducedDataBuilder.BuildEntity).ToList();

            model.ToList().ForEach((m) =>
            {
                m.BankLogoFileInfo = GetFilesContent(m.BankAttachmentUrl).FirstOrDefault();
            });

            int total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);

            return new DataSourceResult<ReducedBankAccountDataViewModel> { data = model, total = total };
        }

        public ReducedBankAccountDataViewModel GetBankAccountWithCondition(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<BankAccount> predicateFilterRelationModel = PreparePredicate(predicateModel);

            BankAccount entity = _entityRepo.GetSingleWithRelationsNotTracked(predicateFilterRelationModel.PredicateWhere,
                                                    predicateFilterRelationModel.PredicateRelations);
            if (entity != null)
            {
                return _reducedDataBuilder.BuildEntity(entity);
            }
            return null;
        }

        public override BankAccountViewModel GetModelById(int id)
        {
            BankAccountViewModel bankAccountViewModel = base.GetModelById(id);
            bankAccountViewModel.IsLinked = IsBankAccountLinked(id).IsLinked;
            return bankAccountViewModel;
        }

        /// <summary>
        /// // Verify if the bankAccount is not related to settlement, paymentSlip or reconciliation
        /// </summary>
        /// <param name="bankAccountViewModel"></param>
        private BankAccountViewModel IsBankAccountLinked(int idBankAccount)
        {
            BankAccountViewModel bankAccount = GetModelAsNoTracked(x => x.Id == idBankAccount,
                            r => r.Settlement, r => r.PaymentSlip, r => r.Reconciliation, r => r.Document, r => r.Project,
                            r => r.TransferOrder);

            if (bankAccount != null && ( (bankAccount.Settlement != null && bankAccount.Settlement.Any())
                    || (bankAccount.Settlement != null && bankAccount.Settlement.Any()) 
                    || (bankAccount.PaymentSlip != null && bankAccount.PaymentSlip.Any()) 
                    || (bankAccount.Reconciliation != null && bankAccount.Reconciliation.Any()) 
                    || (bankAccount.Document != null && bankAccount.Document.Any()) 
                    || (bankAccount.Project != null && bankAccount.Project.Any())
                    || (bankAccount.TransferOrder != null && bankAccount.TransferOrder.Any())
                    ))
            {
                bankAccount.IsLinked = true;
            } 
            return bankAccount;
        }

        public BankAccountViewModel GetBankAccountForRhPaie()
        {
            BankAccountViewModel model = GetModelWithRelationsAsNoTracked(x => x.TypeAccount == NumberConstant.One, b => b.IdBankNavigation);
            return model;
        }
    }
}
