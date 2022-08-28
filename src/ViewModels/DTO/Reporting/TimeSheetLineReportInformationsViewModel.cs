using System.Collections.Generic;
using System.Linq;

namespace ViewModels.DTO.Reporting
{
    public class TimeSheetLineReportInformationsViewModel
    {
        public string Day { set; get; }
        public string DayNumber { set; get; }
        public double ChargeInHour { get; set; }
        public double ChargeInDay { get; set; }
        public string Details { get; set; }
        public bool Hollidays { get; set; }

        public TimeSheetLineReportInformationsViewModel()
        {

        }

        public TimeSheetLineReportInformationsViewModel(TimeSheetLineReportInformationsViewModel timeSheetLineReportInformationsViewModel)
        {
            Day = timeSheetLineReportInformationsViewModel.Day;
            DayNumber = timeSheetLineReportInformationsViewModel.DayNumber;
            ChargeInDay = timeSheetLineReportInformationsViewModel.ChargeInDay;
            ChargeInHour = timeSheetLineReportInformationsViewModel.ChargeInHour;
            Details = timeSheetLineReportInformationsViewModel.Details;
            Hollidays = timeSheetLineReportInformationsViewModel.Hollidays;
        }
    }

    public static class TimeSheetLineReportInformationsViewModelExtensions
    {
        /// <summary>
        /// Check if a date is between two dates, with both edge dates included
        /// </summary>
        /// <param name="date"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static void AddLine(this IList<TimeSheetLineReportInformationsViewModel> lines, TimeSheetLineReportInformationsViewModel line)
        {
            if (lines.Any(m => m.DayNumber.Equals(line.DayNumber)))
            {
                line.Day = string.Empty;
                line.DayNumber = string.Empty;
            }
            lines.Add(line);
        }
    }
}
