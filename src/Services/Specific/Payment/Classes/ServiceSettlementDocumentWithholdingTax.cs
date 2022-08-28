using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Payment.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Classes
{
    public class ServiceSettlementDocumentWithholdingTax : Service<SettlementDocumentWithholdingTaxViewModel, SettlementDocumentWithholdingTax>, IServiceSettlementDocumentWithholdingTax
    {
        public ServiceSettlementDocumentWithholdingTax(IRepository<SettlementDocumentWithholdingTax> entityRepo, IUnitOfWork unitOfWork,
           ISettlementDocumentWithholdingTaxBuilder settlementDocumentWithholdingTaxBuilder, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, settlementDocumentWithholdingTaxBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

        }
    }
}
