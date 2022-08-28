using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Classes
{
    public class ServiceDayOff : Service<DayOffViewModel, DayOff>, IServiceDayOff
    {
        public ServiceDayOff(IRepository<DayOff> entityRepo, 
            IUnitOfWork unitOfWork,
            IDayOffBuilder builder,IRepository<EntityAxisValues> entityRepoEntityAxisValues, 
            IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
