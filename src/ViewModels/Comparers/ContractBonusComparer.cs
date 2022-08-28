using Persistence.Entities;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;

namespace ViewModels.Comparers
{
    public class ContractBonusComparer: IEqualityComparer<ContractBonus>
    {
        public bool Equals(ContractBonus x, ContractBonus y)
        {
            if ((x != null) && (y != null))
            {
                return x.Id == y.Id &&
                    x.IdBonus == y.IdBonus &&
                    x.IdContract == y.IdContract &&
                    x.ValidityStartDate.EqualsDate(y.ValidityStartDate) &&
                    (x.ValidityEndDate.HasValue && y.ValidityEndDate.HasValue && x.ValidityEndDate.Value.EqualsDate(y.ValidityEndDate.Value)
                    || x.ValidityEndDate == y.ValidityEndDate) &&
                    x.Value == y.Value &&
                    x.IsDeleted == y.IsDeleted;
            }
            return false;
        }

        public int GetHashCode(ContractBonus obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("");
            }
            return obj.Id.GetHashCode();
        }
    }
}
