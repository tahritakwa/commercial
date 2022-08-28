﻿using Persistence.Entities;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Administration;

namespace ViewModels.Builders.Specific.Administration.Interfaces
{
    public interface IReducedCurrencyBuilder : IBuilder<ReducedCurrencyViewModel, Currency>
    {
    }
}
