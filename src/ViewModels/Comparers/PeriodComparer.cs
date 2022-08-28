using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Utils.Constants;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Shared;

namespace ViewModels.Comparers
{
    public class PeriodComparer : IEqualityComparer<PeriodViewModel>
    {
        public bool Equals(PeriodViewModel x, PeriodViewModel y)
        {
            if (x.DayOff != null && y.DayOff != null && (!(x.DayOff.Count == y.DayOff.Count) ||
                 !x.DayOff.SequenceEqual(y.DayOff, new DayOffComparer())))
            {
                return false;
            }
            if (x.Hours != null && y.Hours != null && (!(x.Hours.Count == y.Hours.Count) ||
                 !x.Hours.SequenceEqual(y.Hours, new EntityComparator<HoursViewModel>())))
            {
                return false;
            }
            return x.Id == y.Id && x.FirstDayOfWork == y.FirstDayOfWork && x.LastDayOfWork == y.LastDayOfWork &&
                string.Compare(StringToSafe(x.Label), StringToSafe(y.Label), false, CultureInfo.CurrentCulture) == NumberConstant.Zero &&
                x.StartDate.EqualsDate(y.StartDate) && x.EndDate.EqualsDate(y.EndDate);
        }

        public int GetHashCode(PeriodViewModel obj)
        {
            if (obj is null)
                return 0;
            return obj.Id.GetHashCode();
        }

        private static string StringToSafe(string myString)
        {
            return myString ?? "";
        }
    }
}
