﻿using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.Shared;

namespace Services.Specific.Shared.Interfaces
{
    public interface IServicePhone: IService<PhoneViewModel, Phone>
    {
    }
}
