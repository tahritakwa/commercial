﻿using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Shared.Classes
{
    public class ReducedBankBuilder : GenericBuilder<ReducedBankViewModel, Bank>, IReducedBankBuilder
    {

    }

}
