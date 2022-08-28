using Persistence.Entities;
using System.Linq;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class ReducedItemBuilder : GenericBuilder<ReducedItemViewModel, Item>, IReducedItemBuilder
    {
        #region Fields
        private readonly IReducedItemWarehouseBuilder _itemWarehouse;
        #endregion


        #region ctor
        public ReducedItemBuilder(IReducedItemWarehouseBuilder itemWarehouse, ITaxeItemBuilder taxeItemBuilder, ITiersBuilder tiersBuilder)
        {
            _itemWarehouse = itemWarehouse;
        }
        #endregion
        #region Methodes
        public override ReducedItemViewModel BuildEntity(Item entity)
        {
            ReducedItemViewModel model = base.BuildEntity(entity);
            if (entity != null)
            {
                if (entity.ItemWarehouse != null)
                {
                    model.ItemWarehouse = entity.ItemWarehouse.Select(x => _itemWarehouse.BuildEntity(x)).ToList();
                }
            }
            return model;

        }
        public override Item BuildModel(ReducedItemViewModel model)
        {
            Item entity = base.BuildModel(model);
            if (model.ItemWarehouse != null)
            {
                entity.ItemWarehouse = model.ItemWarehouse.Select(x => _itemWarehouse.BuildModel(x)).ToList();
            }
            return entity;
        }
        #endregion
    }
}
