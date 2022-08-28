using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class ItemSalesPriceBuilder : GenericBuilder<ItemSalesPriceViewModel, ItemSalesPrice>, IItemSalesPriceBuilder
    {
    }
}
