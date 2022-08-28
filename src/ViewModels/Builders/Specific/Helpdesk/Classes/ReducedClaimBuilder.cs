﻿using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Helpdesk.Interfaces;
using ViewModels.DTO.Helpdesk;

namespace ViewModels.Builders.Specific.Helpdesk.Classes
{
    public class ReducedClaimBuilder : GenericBuilder<ReducedClaimViewModel, Claim>, IReducedClaimBuilder
    {

    }
}
