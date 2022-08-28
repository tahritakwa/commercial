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
    public class ServiceZipCode : Service<ZipCodeViewModel, ZipCode>, IServiceZipCode
    {
        internal readonly IRepository<User> _entityRepoUser;

        public ServiceZipCode(IRepository<ZipCode> entityRepo, IUnitOfWork unitOfWork,
            IZipCodeBuilder builder, IRepository<User> entityRepoUser,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoUser = entityRepoUser;
        }


    }
}
