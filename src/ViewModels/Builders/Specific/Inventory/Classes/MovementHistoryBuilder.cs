using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class MovementHistoryBuilder : GenericBuilder<MovementHistoryViewModel, MovementHistory>, IMovementHistoryBuilder
    {
        private IItemTiersBuilder _itemTiersBuilder;

        public MovementHistoryBuilder(IItemTiersBuilder itemTiersBuilder)
        {
            _itemTiersBuilder = itemTiersBuilder;
        }
        public override MovementHistoryViewModel BuildEntity(MovementHistory entity)
        {
            MovementHistoryViewModel model = base.BuildEntity(entity);

            if (model != null && model.Discount != null)
            {
                model.Discount = entity.Discount * 100;
            }
            if(entity != null && entity.IdItemNavigation.ItemTiers != null && entity.IdItemNavigation.ItemTiers.Any())
            {
                model.IdItemNavigation.ItemTiers = entity.IdItemNavigation.ItemTiers.Select(x=> _itemTiersBuilder.BuildEntity(x)).ToList();
            }
            return model;
        }
    }
}
