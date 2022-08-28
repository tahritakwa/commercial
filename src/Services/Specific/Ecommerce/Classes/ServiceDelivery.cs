using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Ecommerce.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Ecommerce.Interfaces;
using ViewModels.DTO.Ecommerce;

namespace Services.Specific.Ecommerce.Classes
{
    public class ServiceDelivery : Service<DeliveryViewModel, Delivery>, IServiceDelivery
    {
        public ServiceDelivery(IRepository<Delivery> entityRepo, IUnitOfWork unitOfWork,
          IDeliveryBuilder entityBuilder,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }


}
