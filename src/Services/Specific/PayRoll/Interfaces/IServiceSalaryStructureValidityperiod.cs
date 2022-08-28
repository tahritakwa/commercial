using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceSalaryStructureValidityPeriod : IService<SalaryStructureValidityPeriodViewModel, SalaryStructureValidityPeriod>
    {
        void UpdateSalaryStructureValidityPeriodState();
        void UpdateSalaryStructureWithSalaryRuleWithVariableState(string connectionString);
    }
}
