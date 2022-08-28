using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class VehicleBrandBuilder : GenericBuilder<VehicleBrandViewModel, VehicleBrand>, IVehicleBrandBuilder
    {

        public ReducedVehicleBrandViewModel BuildReducedVehicleBrandEntity(VehicleBrand x)
        {
            return new ReducedVehicleBrandViewModel
            {
                Id = x.Id,
                Code = x.Code,
                Label = x.Label,
                UrlPicture = x.UrlPicture
            };
        }
    }
}
