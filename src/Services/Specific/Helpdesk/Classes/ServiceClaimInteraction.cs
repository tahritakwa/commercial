using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Helpdesk.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Helpdesk.Interfaces;
using ViewModels.DTO.Helpdesk;

namespace Services.Specific.Helpdesk.Classes
{
    public class ServiceClaimInteraction : Service<ClaimInteractionViewModel, ClaimInteraction>, IServiceClaimInteraction
    {
        public readonly IClaimInteractionBuilder _entityBuilder;


        public ServiceClaimInteraction(IRepository<ClaimInteraction> entityRepo,
            IClaimInteractionBuilder claimTypeBuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity,
            IUnitOfWork unitOfWork,
            IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Codification> entityRepoCodification,
            IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, claimTypeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _entityBuilder = claimTypeBuilder;
            _entityRepoEntity = entityRepoEntity;
        }


    }
}
