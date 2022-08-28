﻿using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceJobEmployee : IService<JobEmployeeViewModel, JobEmployee>
    {
        string GetEmployeeJobAsString(int idEmployee);
    }
}
