using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceSalaryStructureValidityPeriodSalaryRule : IService<SalaryStructureValidityPeriodSalaryRuleViewModel, SalaryStructureValidityPeriodSalaryRule>
    {
        IList<string> GetSessionResumeColumnOrder(DateTime month = default);
        IList<SalaryRuleViewModel> GetSalaryStructureHierarchyRules(SalaryStructureViewModel salaryStructureViewModel, DateTime month);
        SalaryStructureViewModel SaveSalaryStructureInMemoryCache(SalaryStructureViewModel salaryStructureViewModel, DateTime month);
    }
}
