﻿using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Inventory.Interfaces
{
    public interface IServiceOemItem : IService<OemItemViewModel, OemItem>
    {
    }
}
