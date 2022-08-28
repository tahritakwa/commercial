using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceTrainingCenterRoom : Service<TrainingCenterRoomViewModel, TrainingCenterRoom>, IServiceTrainingCenterRoom
    {
        public ServiceTrainingCenterRoom(IRepository<TrainingCenterRoom> entityRepo,
         IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, ITrainingCenterRoomBuilder builder,
         IRepository<User> entityRepoUser,
         IEntityAxisValuesBuilder builderEntityAxisValues)
         : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
