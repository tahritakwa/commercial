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
    public class ServiceUserFileAccess : Service<UserFileAccessViewModel, UserFileAccess>, IServiceUserFileAccess
    {
        public ServiceUserFileAccess(IRepository<UserFileAccess> entityRepo,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues, IUnitOfWork unitOfWork, IUserFileAccessBuilder builder,
          IRepository<User> entityRepoUser,
          IEntityAxisValuesBuilder builderEntityAxisValues)
          :base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }



    }
}
