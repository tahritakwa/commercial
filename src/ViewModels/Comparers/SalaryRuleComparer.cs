using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class SalaryRuleComparer : IEqualityComparer<SalaryRuleViewModel>
    {
        public bool Equals(SalaryRuleViewModel x, SalaryRuleViewModel y)
        {
            if (x == null || y == null)
            {
                return false;
            }
            return x.Id == y.Id && 
                x.RuleType == y.RuleType && 
                x.RuleCategory == y.RuleCategory && 
                x.Order == y.Order && 
                x.Applicability == y.Applicability &&
                x.DependNumberDaysWorked == y.DependNumberDaysWorked;
        }

        public int GetHashCode(SalaryRuleViewModel obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("");
            }
            return obj.Id.GetHashCode() ^
                obj.RuleType.GetHashCode() ^
                obj.RuleCategory.GetHashCode() ^
                obj.Order.GetHashCode() ^
                obj.Applicability.GetHashCode() ^
                obj.DependNumberDaysWorked.GetHashCode();
        }
    }
}
