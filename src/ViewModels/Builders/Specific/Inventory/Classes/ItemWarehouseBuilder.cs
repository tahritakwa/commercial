using Persistence.Entities;
using Settings.Exceptions;
using Utils.Enumerators;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class ItemWarehouseBuilder : GenericBuilder<ItemWarehouseViewModel, ItemWarehouse>, IItemWarehouseBuilder
    {
        public override ItemWarehouseViewModel BuildEntity(ItemWarehouse entity)
        {
            ItemWarehouseViewModel model = base.BuildEntity(entity);

            if (model != null && model.IdWarehouseNavigation != null)
            {
                model.WarehouseName = model.IdWarehouseNavigation.WarehouseName;
            }
            return model;
        }

        public override ItemWarehouse BuildModel(ItemWarehouseViewModel model)
        {
            if (model.MaxQuantity < model.MinQuantity)
            {
                throw new CustomException(CustomStatusCode.WarehouseQuantityMinMax);
            }
            return base.BuildModel(model);
        }

        public ItemWarehouseListItemViewModel BuildItemWarehouse(ItemWarehouseViewModel itemWarehouse)
        {
            return new ItemWarehouseListItemViewModel
            {
                WarehouseName = itemWarehouse.WarehouseName,
                Shelf= itemWarehouse.Shelf,
                Storage= itemWarehouse.Storage,
                AvailableQuantity= itemWarehouse.AvailableQuantity,
                CMD= itemWarehouse.CMD,
                CRP= itemWarehouse.CRP,
                MinQuantity= itemWarehouse.MinQuantity,
                TradedQuantity= itemWarehouse.TradedQuantity,
                State= itemWarehouse.State,
                IdItem= itemWarehouse.IdItem,
                IsCentralWarehouse= itemWarehouse.IdWarehouseNavigation.IsCentral,
                SumOnOrderedReservedQuantity=itemWarehouse.SumOnOrderedReservedQuantity,
                ToOrderQuantity=itemWarehouse.ToOrderQuantity,
                ReservedQuantityInDelivery=itemWarehouse.ReservedQuantityInDelivery,
                OutTransferedQuantity=itemWarehouse.OutTransferedQuantity,
                InTransferedQuantity=itemWarehouse.InTransferedQuantity
            };
        }
    }
}
