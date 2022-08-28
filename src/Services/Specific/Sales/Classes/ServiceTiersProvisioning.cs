using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Sales.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Provisioning;

namespace Services.Specific.Sales.Classes
{

    public class ServiceTiersProvisioning : Service<TiersProvisioningViewModel, TiersProvisioning>, IServiceTiersProvisioning
        {
            public ServiceTiersProvisioning(IRepository<TiersProvisioning> entityRepo,
              IUnitOfWork unitOfWork,

              ITiersProvisioningBuilder builder,
              IRepository<EntityAxisValues> entityRepoEntityAxisValues,
              IEntityAxisValuesBuilder builderEntityAxisValues,
              IRepository<Entity> entityRepoEntity,
              IRepository<EntityCodification> entityRepoEntityCodification,
              IRepository<Codification> entityRepoCodification,
              IServiceCodification serviceCodification,
              IRepository<DocumentLine> entityRepoDocumentLine,
              IServiceDocument serviceDocument, IRepository<ItemKit> entityRepoItemKit) : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues,
                  entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
            { }

       
    }
    
}
