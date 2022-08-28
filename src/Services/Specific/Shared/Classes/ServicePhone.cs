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
    public class ServicePhone : Service<PhoneViewModel, Phone>, IServicePhone
    {
        public ServicePhone(IRepository<Phone> entityRepo, IUnitOfWork unitOfWork,
            IPhoneBuilder PhoneBuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity,
            IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, PhoneBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
