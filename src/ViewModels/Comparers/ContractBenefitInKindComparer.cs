using Persistence.Entities;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;

namespace ViewModels.Comparers
{
    public class ContractBenefitInKindComparer: IEqualityComparer<ContractBenefitInKind>
    {
        public bool Equals(ContractBenefitInKind x, ContractBenefitInKind y)
        {
            if ((x != null) && (y != null))
            {
                return x.Id == y.Id && 
                    x.IdContract == y.IdContract &&
                    x.ValidityStartDate.EqualsDate(y.ValidityStartDate)  &&
                    x.IdBenefitInKind == y.IdBenefitInKind &&
                    x.ValidityEndDate == y.ValidityEndDate &&
                    x.Value == y.Value &&
                    x.IsDeleted == y.IsDeleted;
            }
            return false;
        }

        public int GetHashCode(ContractBenefitInKind obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("");
            }
            return obj.Id.GetHashCode();
        }
    }
}
