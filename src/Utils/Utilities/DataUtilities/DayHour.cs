using Utils.Constants;

namespace Utils.Utilities.DataUtilities
{
    public class NumberOfDaysDayHour
    {
        public DayHour NumberOfDaysWorked { get; set; }
        public DayHour NumberOfLeavesDays { get; set; }
        public DayHour NumberOfPaidLeavesDays { get; set; }
        public DayHour NumberOfUnPaidLeavesDays { get; set; }
        public DayHour NumberOfDaysOff { get; set; }

        public NumberOfDaysDayHour()
        {
            NumberOfDaysWorked = new DayHour();
            NumberOfLeavesDays = new DayHour();
            NumberOfPaidLeavesDays = new DayHour();
            NumberOfUnPaidLeavesDays = new DayHour();
            NumberOfDaysOff = new DayHour();
        }
    }

    public class DayHour
    {
        public double Day { get; set; }
        public double Hour { get; set; }
        public double DayHourInDecimal { get; set; }

        public DayHour()
        {
            Day = NumberConstant.Zero;
            Hour = NumberConstant.Zero;
            DayHourInDecimal = NumberConstant.Zero;
        }

        public DayHour(double Day, double Hour)
        {
            this.Day = Day;
            this.Hour = Hour;
            DayHourInDecimal = NumberConstant.Zero;
        }

        public DayHour(double Day, double Hour, double DayHourInDecimal)
        {
            this.Day = Day;
            this.Hour = Hour;
            this.DayHourInDecimal = DayHourInDecimal;
        }

        public DayHour(DayHour dayHour)
        {
            Day = dayHour.Day;
            Hour = dayHour.Hour;
            DayHourInDecimal = dayHour.DayHourInDecimal;
        }

        public static DayHour operator + (DayHour firstDayHour, DayHour secondDayHour)
        {
            return new DayHour(firstDayHour.Day + secondDayHour.Day, firstDayHour.Hour + secondDayHour.Hour, firstDayHour.DayHourInDecimal + secondDayHour.DayHourInDecimal);
        }

        public static bool operator >(DayHour firstDayHour, int number) => firstDayHour.Day > number || firstDayHour.Hour > number;

        public static bool operator < (DayHour firstDayHour, int number) => firstDayHour.Day < number || firstDayHour.Hour < number;
    }
}
