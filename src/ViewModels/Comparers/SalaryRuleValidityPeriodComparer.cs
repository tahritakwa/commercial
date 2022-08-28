using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class SalaryRuleValidityPeriodComparer : IEqualityComparer<SalaryRuleValidityPeriodViewModel>
    {
       public bool Equals(SalaryRuleValidityPeriodViewModel x, SalaryRuleValidityPeriodViewModel y)
        {
            if (x is null || y is null)
            {
                return false;
            }
            return x.Id == y.Id &&
                x.StartDate.EqualsDate(y.StartDate) &&
                x.Rule == y.Rule &&
                x.IdSalaryRule == y.IdSalaryRule &&
                x.IsDeleted == y.IsDeleted;
        }

        public int GetHashCode(SalaryRuleValidityPeriodViewModel obj)
        {
            if (obj is null)
                return 0;
            return obj.Id.GetHashCode() ^
                obj.IdSalaryRule.GetHashCode();
        }
    }
}
