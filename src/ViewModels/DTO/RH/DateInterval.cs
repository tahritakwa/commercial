using System;

namespace ViewModels.DTO.RH
{
    public class DateInterval
    {
        public DateTime StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public DayOfWeek DayOfWeek { get; set; }
        public string DayName { get; set; }

        public DateInterval()
        {

        }

        public DateInterval(DateTime startDate)
        {
            StartDate = startDate;
        }

        public DateInterval(DateTime startDate, DateTime? endDate)
        {
            StartDate = startDate;
            EndDate = endDate;
        }
    }
}
