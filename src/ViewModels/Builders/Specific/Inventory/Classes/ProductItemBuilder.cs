﻿using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Inventory.Classes
{
    public class ProductItemBuilder : GenericBuilder<ProductItemViewModel, ProductItem>, IProductItemBuilder
    {

    }
}
