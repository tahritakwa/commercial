﻿using Persistence.Entities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Interfaces
{
    public interface IItemSalesPriceBuilder : IBuilder<ItemSalesPriceViewModel, ItemSalesPrice>
    {
    }
}
