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
    public class ServiceDetailsSettlementMode : Service<DetailsSettlementModeViewModel, DetailsSettlementMode>, IServiceDetailsSettlementMode
    {
        internal readonly IRepository<User> _entityRepoUser;
        public ServiceDetailsSettlementMode(IRepository<DetailsSettlementMode> entityRepo, IUnitOfWork unitOfWork,
           IDetailsSettlementModeBuilder detailsSettlementModeBuilder, IRepository<User> entityRepoUser,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, detailsSettlementModeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoUser = entityRepoUser;
        }
    }
}
