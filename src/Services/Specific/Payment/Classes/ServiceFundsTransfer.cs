using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Payment.Interfaces;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Classes
{
    public class ServiceFundsTransfer : Service<FundsTransferViewModel, FundsTransfer>, IServiceFundsTransfer
    {
        private readonly IRepository<CashRegister> _cashRegisterRepo;
        private readonly ICashRegisterBuilder _cashRegisterBuilder;
        public ServiceFundsTransfer(IRepository<FundsTransfer> entityRepo, IUnitOfWork unitOfWork,
            IFundsTransferBuilder fundsTransferBuilder, ICashRegisterBuilder cashRegisterBuilder,
            IRepository<CashRegister> cashRegisterRepo,
            IRepository<Entity> entityRepoEntity, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<EntityCodification> entityRepoEntityCodification,
            IRepository<Codification> entityRepoCodification)
            : base(entityRepo, unitOfWork, fundsTransferBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity,
                  entityRepoEntityCodification, entityRepoCodification)
        {
            _cashRegisterRepo = cashRegisterRepo;
            _cashRegisterBuilder = cashRegisterBuilder;
        }

        public DataSourceResult<CashRegisterViewModel> GetSourceCashsByTransferType(int? transferType)
        {
            IList<CashRegisterViewModel> models = new List<CashRegisterViewModel>();
            IQueryable <CashRegister> entities = _cashRegisterRepo.QuerableGetAll();
            switch (transferType)
            {
                case (int)FundsTransferTypeEnumerator.Supply_Cash_Recipe:
                    entities = entities.Where(x => x.Type == (int)CashRegisterTypeEnumerator.Principal);
                    break;
                case (int)FundsTransferTypeEnumerator.Supply_Expense_Fund:
                    entities = entities.Where(x => x.Type == (int)CashRegisterTypeEnumerator.Principal);
                    break;
                case (int)FundsTransferTypeEnumerator.Supply_POS:
                    entities = entities.Where(x => x.Type == (int)CashRegisterTypeEnumerator.RecipeBox);
                    break;
                case (int)FundsTransferTypeEnumerator.Close_POS:
                    entities = entities.Where(x => x.Type == (int)CashRegisterTypeEnumerator.POS);
                    break;
            }
            models = entities.Select(_cashRegisterBuilder.BuildEntity).ToList();
            long total = models.Count;
            return new DataSourceResult<CashRegisterViewModel> { data = models, total = total };
        }

        public DataSourceResult<CashRegisterViewModel> GetDestinationCashsByTransferType(int? transferType)
        {
            IList<CashRegisterViewModel> models = new List<CashRegisterViewModel>();
            IQueryable<CashRegister> entities = _cashRegisterRepo.QuerableGetAll();
            switch (transferType)
            {
                case (int)FundsTransferTypeEnumerator.Supply_Cash_Recipe:
                    entities = entities.Where(x => x.Type == (int)CashRegisterTypeEnumerator.RecipeBox);
                    break;
                case (int)FundsTransferTypeEnumerator.Supply_Expense_Fund:
                    entities = entities.Where(x => x.Type == (int)CashRegisterTypeEnumerator.ExpenseFund);
                    break;
                case (int)FundsTransferTypeEnumerator.Supply_POS:
                    entities = entities.Where(x => x.Type == (int)CashRegisterTypeEnumerator.POS);
                    break;
                case (int)FundsTransferTypeEnumerator.Close_POS:
                    entities = entities.Where(x => x.Type == (int)CashRegisterTypeEnumerator.Principal);
                    break;
            }
            models = entities.Select(_cashRegisterBuilder.BuildEntity).ToList();
            long total = models.Count;
            return new DataSourceResult<CashRegisterViewModel> { data = models, total = total };
        }

        public override object AddModelWithoutTransaction(FundsTransferViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {

            if (model.Type == (int)FundsTransferTypeEnumerator.Close_POS)
            {
                model.Status = (int)FundsTransferStateEnumerator.CLOSED;
            }
            else
            {
                model.Status = (int)FundsTransferStateEnumerator.SUPPLIED;
            }
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }
    }
}
