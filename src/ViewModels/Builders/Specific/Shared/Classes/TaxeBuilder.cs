﻿using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Inventory;

namespace ViewModels.Builders.Specific.Shared.Classes
{
    public class TaxeBuilder : GenericBuilder<TaxeViewModel, Taxe>, ITaxeBuilder
    {

    }
}
