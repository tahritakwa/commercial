using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Utils.Constants;
using Utils.Utilities.DataUtilities;

namespace ViewModels.Comparers
{
    public class ContractComparer : IEqualityComparer<Contract>
    {
        public bool Equals(Contract x, Contract y)
        {
            if (x is null || y is null)
            {
                return false;
            }
            if ( (x.BaseSalary != null && y.BaseSalary != null) && (!(x.BaseSalary.Count == y.BaseSalary.Count) ||
                 !x.BaseSalary.SequenceEqual(y.BaseSalary, new BaseSalaryComparer()) ))
            {
                return false;
            }
            if ((x.ContractBonus != null && y.ContractBonus != null) && (!(x.ContractBonus.Count == y.ContractBonus.Count) ||
                !x.ContractBonus.SequenceEqual(y.ContractBonus, new ContractBonusComparer()) ))
            {
                return false;
            }
            if ((x.ContractBenefitInKind != null && y.ContractBenefitInKind != null) && (!(x.ContractBenefitInKind.Count == y.ContractBenefitInKind.Count) ||
                !x.ContractBenefitInKind.SequenceEqual(y.ContractBenefitInKind, new ContractBenefitInKindComparer())))
            {
                return false;
            }
            if (x.EndDate.HasValue && y.EndDate.HasValue && y.EndDate.Value.Date != x.EndDate.Value.Date)
            {
                return false;
            }
            return x.Id == y.Id && string.Compare(StringToSafe(x.ContractReference), StringToSafe(y.ContractReference), false, CultureInfo.CurrentCulture) == NumberConstant.Zero &&
                x.StartDate.EqualsDate(y.StartDate) &&
            (x.EndDate.HasValue == y.EndDate.HasValue) &&
            (x.WorkingTime == y.WorkingTime) && x.IdSalaryStructure == y.IdSalaryStructure &&
            x.IdContractType == y.IdContractType && x.IdEmployee == y.IdEmployee
            && x.State == y.State && x.IdCnss == y.IdCnss;
        }

        public int GetHashCode(Contract obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("");
            }
            return obj.Id.GetHashCode();
        }

        private static string StringToSafe(string myString)
        {
            return myString ?? "";
        }
    }
}
