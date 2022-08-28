using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class BenefitInKindComparer : IEqualityComparer<BenefitInKindViewModel>
    {
       public bool Equals(BenefitInKindViewModel x, BenefitInKindViewModel y)
        {
            if (x is null || y is null)
            {
                return false;
            }
            return x.Id == y.Id 
                   && x.IdCnss == y.IdCnss
                   && x.IsTaxable == y.IsTaxable
                   && x.DependNumberDaysWorked == y.DependNumberDaysWorked;
        }

        public int GetHashCode(BenefitInKindViewModel obj)
        {
            if (ReferenceEquals(obj, null))
                return 0;
            return obj.Id.GetHashCode() ^ obj.IdCnss.GetHashCode() ^ obj.IsTaxable.GetHashCode();
        }
    }
}
