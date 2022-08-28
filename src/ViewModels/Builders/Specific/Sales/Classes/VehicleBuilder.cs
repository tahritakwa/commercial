using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Sales;

namespace ViewModels.Builders.Specific.Sales.Classes
{
    public class VehicleBuilder : GenericBuilder<VehicleViewModel, Vehicle>, IVehicleBuilder
    {
        public override VehicleViewModel BuildEntity(Vehicle entity)
        {
            VehicleViewModel model = base.BuildEntity(entity);
            if (entity != null)
            {
                if (entity.IdVehicleBrandNavigation != null && entity.IdVehicleModelNavigation != null)
                {
                    model.VehicleName = entity.IdVehicleBrandNavigation.Label + "-" + entity.IdVehicleModelNavigation.Label;
                }
            }
            return model;

        }
    }
}
