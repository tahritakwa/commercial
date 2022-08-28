using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class ItemKitBuilder : GenericBuilder<ItemKitViewModel, ItemKit>, IItemKitBuilder
    {
        private readonly ITiersBuilder _tiersBuilder;

        public ItemKitBuilder(ITiersBuilder tiersBuilder)
        {
            _tiersBuilder = tiersBuilder;
        }

        public override ItemKitViewModel BuildEntity(ItemKit entity)
        {
            ItemKitViewModel model = base.BuildEntity(entity);
            if (entity != null)
            {
                if (entity.IdItemNavigation != null)
                {
                    model.Code = entity.IdItemNavigation.Code;
                    model.Description = entity.IdItemNavigation.Description;
                }
            }
            return model;

        }

    }
}
