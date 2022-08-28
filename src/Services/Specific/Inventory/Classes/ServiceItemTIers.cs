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
    public class ServiceItemTiers : Service<ItemTiersViewModel, ItemTiers>, IServiceItemTiers
    {
        public ServiceItemTiers(IRepository<ItemTiers> entityRepo,
    IUnitOfWork unitOfWork,
    IItemTiersBuilder builder,
    IRepository<Entity> entityRepoEntity,
    IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
     : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }
    }
}
