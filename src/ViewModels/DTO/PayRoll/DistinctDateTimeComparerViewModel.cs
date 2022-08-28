using System;
using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public class DistinctDateTimeComparerViewModel : IEqualityComparer<DateTime>
    {
        public bool Equals(DateTime x, DateTime y)
        {
            return x.Day == y.Day &&
                x.Month == y.Month &&
                x.Year == y.Year;
        }
        public int GetHashCode(DateTime obj)
        {
            return obj.Day.GetHashCode() ^
                obj.Month.GetHashCode() ^
                obj.Year.GetHashCode();
        }
    }
}
