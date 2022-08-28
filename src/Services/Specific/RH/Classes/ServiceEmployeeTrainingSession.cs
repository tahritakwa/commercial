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
    public class ServiceEmployeeTrainingSession : Service<EmployeeTrainingSessionViewModel, EmployeeTrainingSession>, IServiceEmployeeTrainingSession
    {
        public ServiceEmployeeTrainingSession(IRepository<EmployeeTrainingSession> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IEmployeeTrainingSessionBuilder builder,
          IRepository<User> entityRepoUser,
          IEntityAxisValuesBuilder builderEntityAxisValues)
          : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }



    }
}
