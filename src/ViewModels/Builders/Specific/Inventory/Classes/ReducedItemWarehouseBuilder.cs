using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class ReducedItemWarehouseBuilder : GenericBuilder<ReducedItemWarehouseViewModel, ItemWarehouse>, IReducedItemWarehouseBuilder
    {
        //public override ItemWarehouseViewModel BuildEntity(ItemWarehouse entity)
        //{
        //    ItemWarehouseViewModel model = base.BuildEntity(entity);

        //    if (model!=null && model.IdWarehouseNavigation != null)
        //    {
        //        model.WarehouseName = model.IdWarehouseNavigation.WarehouseName;
        //    }
        //    return model;
        //}

        //public override ItemWarehouse BuildModel(ItemWarehouseViewModel model)
        //{
        //    if(model.MaxQuantity<model.MinQuantity)
        //    {
        //        throw new CustomException(CustomStatusCode.WarehouseQuantityMinMax);
        //    }
        //    return base.BuildModel(model);
        //}
    }
}
