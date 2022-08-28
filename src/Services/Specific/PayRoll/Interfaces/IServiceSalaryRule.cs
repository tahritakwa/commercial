using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceSalaryRule : IService<SalaryRuleViewModel, SalaryRule>
    {
        IList<Payslip> CheckIfSalaryRuleIsAssociatedWithAnyPayslip(SalaryRuleViewModel salaryRuleViewModel);
        IList<SalaryRuleViewModel> GetSalaryRuleOrderedByApplicabilityThenByOrder();
    }
}
