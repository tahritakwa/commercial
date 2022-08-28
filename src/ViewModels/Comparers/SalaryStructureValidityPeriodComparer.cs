using System.Collections.Generic;
using System.Linq;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class SalaryStructureValidityPeriodComparer : IEqualityComparer<SalaryStructureValidityPeriodViewModel>
    {
        public bool Equals(SalaryStructureValidityPeriodViewModel x, SalaryStructureValidityPeriodViewModel y)
        {
            if (x is null || y is null)
            {
                return false;
            }
            bool collectionComparison = false;
            if (x.SalaryStructureValidityPeriodSalaryRule != null && y.SalaryStructureValidityPeriodSalaryRule != null)
            {
                collectionComparison = x.SalaryStructureValidityPeriodSalaryRule.SequenceEqual(y.SalaryStructureValidityPeriodSalaryRule, 
                    new SalaryStructureValidityPeriodSalaryRuleComparer());
            }
            return x.Id == y.Id &&
                x.StartDate.EqualsDate(y.StartDate) &&
                collectionComparison &&
                x.IdSalaryStructure == y.IdSalaryStructure &&
                x.IsDeleted == y.IsDeleted;
        }

        public int GetHashCode(SalaryStructureValidityPeriodViewModel obj)
        {
            if (obj is null)
                return 0;
            return obj.Id.GetHashCode() ^
                obj.IdSalaryStructure.GetHashCode();
        }
    }
}
