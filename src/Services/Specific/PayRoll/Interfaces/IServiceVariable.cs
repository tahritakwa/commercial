using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceVariable : IService<VariableViewModel, Variable>
    {
        IList<Payslip> CheckIfVariableIsUsedInAnyRuleUsedinAnyPayslip(VariableViewModel variableViewModel);
    }
}
