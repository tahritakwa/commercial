using Persistence.Entities;
using System;
using System.Collections.Generic;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.B2B;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales.Document;

namespace ViewModels.Builders.Specific.Inventory.Interfaces
{
    public interface IItemBuilder : IBuilder<ItemViewModel, Item>
    {
        ItemListViewModel BuildItem(ItemViewModel x);
        ReducedListItemViewModel BuildListItem(Item x, int? idWarhouse=null, List<IdItemAndReliquatQtyViewModel> idItemAndReliquatQtyViewModel=null);
        ItemSheetViewModel BuildItemSheet(Item item);
        ItemB2bViewModel BuildListItemB2b(ItemViewModel x,DateTime searchDate,List<ItemSalesPriceViewModel> listTtemSalesPrice = null, int Precision=3, List<EquivalenceItemForBtoBViewModel> listEquivanceItemForBtoB=null);
        ItemViewModel BuildItemEntity(Item entity);
    }
}
