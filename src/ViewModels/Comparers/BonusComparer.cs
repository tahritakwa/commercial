using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class BonusComparer : IEqualityComparer<BonusViewModel>
    {
       public bool Equals(BonusViewModel x, BonusViewModel y)
        {
            if (x is null || y is null)
            {
                return false;
            }
            return x.Id == y.Id 
                   && x.IdCnss == y.IdCnss
                   && x.IsTaxable == y.IsTaxable
                   && x.IsFixe == y.IsFixe
                   && x.DependNumberDaysWorked == y.DependNumberDaysWorked;
        }

        public int GetHashCode(BonusViewModel obj)
        {
            if (ReferenceEquals(obj, null))
                return 0;
            return obj.Id.GetHashCode() ^ obj.IdCnss.GetHashCode() ^ obj.IsTaxable.GetHashCode() ^ obj.IsFixe.GetHashCode();
        }
    }
}
