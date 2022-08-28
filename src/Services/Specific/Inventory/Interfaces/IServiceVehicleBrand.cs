using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceVehicleBrand : IService<VehicleBrandViewModel, VehicleBrand>
    {
        List<VehicleBrandViewModel> AddTecDocMissingVehicleBrands(List<string> brands, string userMail);
    }
}
