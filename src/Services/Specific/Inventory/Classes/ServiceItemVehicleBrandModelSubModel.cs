using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Classes
{
    public class ServiceItemVehicleBrandModelSubModel : Service<ItemVehicleBrandModelSubModelViewModel, ItemVehicleBrandModelSubModel>, IServiceItemVehicleBrandModelSubModel
    {


        public ServiceItemVehicleBrandModelSubModel(IRepository<ItemVehicleBrandModelSubModel> entityRepo, IUnitOfWork unitOfWork,
          IItemVehicleBrandModelSubModelBuilder entityBuilder,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues)
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }

    }
}
