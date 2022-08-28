using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class BonusValidityPeriodComparer : IEqualityComparer<BonusValidityPeriodViewModel>
    {
       public bool Equals(BonusValidityPeriodViewModel x, BonusValidityPeriodViewModel y)
        {
            if (x is null || y is null)
            {
                return false;
            }
            return x.Id == y.Id && 
                x.Value == y.Value &&
                x.StartDate == y.StartDate &&
                x.IsDeleted == y.IsDeleted;
        }

        public int GetHashCode(BonusValidityPeriodViewModel obj)
        {
            if (ReferenceEquals(obj, null))
                return 0;
            return obj.Id.GetHashCode() ^ obj.Value.GetHashCode() ^ obj.StartDate.GetHashCode();
        }
    }
}
