using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.Ecommerce;

namespace Services.Specific.Ecommerce.Interfaces
{
    public interface IServiceDelivery : IService<DeliveryViewModel, Delivery>
    {
    }
}
