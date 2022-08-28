using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace Services.Specific.Sales.Classes
{
    public class ServicePurchaseSettings : Service<PurchaseSettingsViewModel, PurchaseSettings>, IServicePurchaseSettings
    {


        public ServicePurchaseSettings(IRepository<PurchaseSettings> entityRepo,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IUnitOfWork unitOfWork,
            IPurchaseSettingsBuilder builder,
            IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

        }
    }
}
