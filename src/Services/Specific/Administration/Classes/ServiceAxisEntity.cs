using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.DTO.Administration;

namespace Services.Specific.Administration.Classes
{
    public class ServiceAxisEntity : Service<AxisEntityViewModel, AxisEntity>, IServiceAxisEntity
    {

        public ServiceAxisEntity(IRepository<AxisEntity> entityRepo, IUnitOfWork unitOfWork,
           IAxisEntityBuilder entityBuilder, IRepository<User> entityRepoUser,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {

        }
    }
}
