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
    public class ServiceDeliveryType : Service<DeliveryTypeViewModel, DeliveryType>, IServiceDeliveryType
    {
        internal readonly IRepository<User> _entityRepoUser;
        public ServiceDeliveryType(IRepository<DeliveryType> entityRepo, IUnitOfWork unitOfWork, IRepository<User> entityRepoUser,
           IDeliveryTypeBuilder deliveryTypeBuilder, IRepository<Entity> entityRepoEntity,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, deliveryTypeBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoUser = entityRepoUser;
        }
    }
}
