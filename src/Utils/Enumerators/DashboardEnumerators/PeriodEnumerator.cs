using System;

namespace Utils.Enumerators.DashboardEnumerators
{
    public class Period
    {
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
    }
    public enum PeriodEnumerator
    {
        CurrentMonth = 1,
        LastMonth = 2,
        LastSixMonth = 3,
        CurrentYear = 4,
        LastYear = 5
    }

}
