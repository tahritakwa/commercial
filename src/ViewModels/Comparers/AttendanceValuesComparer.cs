using System.Collections.Generic;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Comparers
{
    public class AttendanceValuesComparer : IEqualityComparer<AttendanceViewModel>
    {
        bool IEqualityComparer<AttendanceViewModel>.Equals(AttendanceViewModel x, AttendanceViewModel y)
        {
            return (x.Id == y.Id 
                && x.NumberDaysWorked.Equals(y.NumberDaysWorked)
                && x.NumberDaysPaidLeave.Equals(y.NumberDaysPaidLeave)
                 && x.NumberDaysNonPaidLeave.Equals(y.NumberDaysNonPaidLeave)
                  && x.AdditionalHourOne.Equals(y.AdditionalHourOne)
                   && x.AdditionalHourTwo.Equals(y.AdditionalHourTwo)
                    && x.AdditionalHourThree.Equals(y.AdditionalHourThree)
                     && x.AdditionalHourFour.Equals(y.AdditionalHourFour));
        }

        int IEqualityComparer<AttendanceViewModel>.GetHashCode(AttendanceViewModel obj)
        {
            if (ReferenceEquals(obj, null))
                return 0;

            return obj.Id.GetHashCode();
        }
    }
}