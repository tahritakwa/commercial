using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Shared;

namespace ViewModels.Comparers
{
    public class DayOffComparer : IEqualityComparer<DayOffViewModel>
    {
        public bool Equals(DayOffViewModel x, DayOffViewModel y)
        {
            return x.Id == y.Id && x.IsDeleted == y.IsDeleted && x.IdPeriod == y.IdPeriod && x.Date.EqualsDate(y.Date);
        }

        int IEqualityComparer<DayOffViewModel>.GetHashCode(DayOffViewModel obj)
        {
            if (ReferenceEquals(obj, null))
                return 0;

            return obj.Id.GetHashCode();
        }
    }
}
