using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.Provisioning;

namespace Services.Specific.Sales.Interfaces
{
    public interface IServiceProvisioningDetails : IService<ProvisioningDetailsViewModel, ProvisioningDetails>
    {
    }
}
