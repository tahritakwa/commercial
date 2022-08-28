using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class VariableValidityPeriodComparer : IEqualityComparer<VariableValidityPeriodViewModel>
    {
       public bool Equals(VariableValidityPeriodViewModel x, VariableValidityPeriodViewModel y)
        {
            if (x is null || y is null)
            {
                return false;
            }
            return x.Id == y.Id &&
                x.StartDate.EqualsDate(y.StartDate) &&
                x.Formule == y.Formule &&
                x.IdVariable == y.IdVariable &&
                x.IsDeleted == y.IsDeleted;
        }

        public int GetHashCode(VariableValidityPeriodViewModel obj)
        {
            if (obj is null)
                return 0;
            return obj.Id.GetHashCode() ^
                obj.IdVariable.GetHashCode();
        }
    }
}
