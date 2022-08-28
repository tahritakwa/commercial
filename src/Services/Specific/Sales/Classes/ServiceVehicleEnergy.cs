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
    public class ServiceVehicleEnergy : Service<VehicleEnergyViewModel, VehicleEnergy>, IServiceVehicleEnergy
    {
        public ServiceVehicleEnergy(IRepository<VehicleEnergy> entityRepo, IUnitOfWork unitOfWork, IVehicleEnergyBuilder builder, IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<EntityAxisValues> entityRepoEntityAxisValues)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
