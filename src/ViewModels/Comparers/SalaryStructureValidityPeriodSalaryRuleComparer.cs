using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class SalaryStructureValidityPeriodSalaryRuleComparer : IEqualityComparer<SalaryStructureValidityPeriodSalaryRuleViewModel>
    {
        public bool Equals(SalaryStructureValidityPeriodSalaryRuleViewModel x, SalaryStructureValidityPeriodSalaryRuleViewModel y)
        {
            if (x is null || y is null)
            {
                return false;
            }
            return x.Id == y.Id &&
                x.IdSalaryRule == y.IdSalaryRule &&
                x.IdSalaryStructureValidityPeriod == y.IdSalaryStructureValidityPeriod &&
                x.IsDeleted == y.IsDeleted;
        }

        public int GetHashCode(SalaryStructureValidityPeriodSalaryRuleViewModel obj)
        {
            if (obj is null)
                return 0;
            return obj.Id.GetHashCode() ^
                obj.IdSalaryRule.GetHashCode() ^
                obj.IdSalaryStructureValidityPeriod.GetHashCode();
        }
    }
}
