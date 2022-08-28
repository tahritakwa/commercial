using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class ReducedItemViewModelBuilder : GenericBuilder<ReducedItemViewModel, ItemViewModel>, IReducedItemViewModelBuilder
    {
        #region Fields
        private readonly IItemWarehouseBuilder _itemWarehouse;
        #endregion


        #region ctor
        public ReducedItemViewModelBuilder(IItemWarehouseBuilder itemWarehouse, ITaxeItemBuilder taxeItemBuilder, ITiersBuilder tiersBuilder)
        {
            _itemWarehouse = itemWarehouse;
        }
        #endregion
        #region Methodes
        public override ReducedItemViewModel BuildEntity(ItemViewModel entity)
        {
            ReducedItemViewModel model = base.BuildEntity(entity);
            if (entity != null)
            {
            }
            return model;

        }
        public override ItemViewModel BuildModel(ReducedItemViewModel model)
        {
            ItemViewModel entity = base.BuildModel(model);
            return entity;
        }
        #endregion
    }
}
