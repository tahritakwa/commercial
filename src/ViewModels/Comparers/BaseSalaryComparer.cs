using Persistence.Entities;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;

namespace ViewModels.Comparers
{
    public class BaseSalaryComparer : IEqualityComparer<BaseSalary>
    {
        public bool Equals(BaseSalary x, BaseSalary y)
        {
            if ((x != null) && (y != null))
            {
                return x.Id == y.Id &&
                    x.StartDate.EqualsDate(y.StartDate) &&
                    x.Value == y.Value && 
                    x.IdContract == y.IdContract && 
                    x.IsDeleted == y.IsDeleted;
            }
            return false;
        }

        public int GetHashCode(BaseSalary obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("");
            }
            return obj.Id.GetHashCode();
        }
    }
}
