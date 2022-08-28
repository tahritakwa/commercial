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
    public class ServiceTaxeGroupTiersConfig : Service<TaxeGroupTiersConfigViewModel, TaxeGroupTiersConfig>, IServiceTaxeGroupTiersConfig
    {
        public ServiceTaxeGroupTiersConfig(IRepository<TaxeGroupTiersConfig> entityRepo,
            IUnitOfWork unitOfWork,
            IRepository<Entity> entityRepoEntity,
            ITaxeGroupTiersConfigBuilder builder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

        }


    }
}
