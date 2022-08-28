using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceExitEmployeePayLineSalaryRule : IService<ExitEmployeePayLineSalaryRuleViewModel, ExitEmployeePayLineSalaryRule>
    {
        void GetResumeForExitEmployee(ExitEmployeePayLineViewModel model, Contract contract, DateTime month);
    }
}
