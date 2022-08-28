using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces.ISpecificLanguage
{
    public interface ISemanticAnalyzer
    {
        Dictionary<string, double> Execute(SubTreeViewModel tree, int idEmployee, int idContract, DateTime month, SalaryRuleViewModel salaryRule, double numberDaysWorked);
        void InitializeBuffer();
        void ClearBuffer();
        void SetValueInBuffer(SalaryRuleViewModel salaryRuleViewModel);
        void SetValueInBuffer(string key, double value);
    }
}
