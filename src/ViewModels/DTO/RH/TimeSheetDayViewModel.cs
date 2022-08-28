using System;
using System.Collections.Generic;

namespace ViewModels.DTO.RH
{
    public class TimeSheetDayViewModel
    {
        public DateTime Day { get; set; }
        public bool Hollidays { get; set; }
        public int WeekNumberInYear { get; set; }
        public int? WaitingLeave { get; set; }
        public string WaitingLeaveTypeName { get; set; }
        public ICollection<TimeSheetLineViewModel> TimeSheetLine { get; set; }
        public ICollection<ProjectViewModel> Project { get; set; }
        public IList<KeyValuePair<string, TimeSpan>> Hours { get; set; }

        public TimeSheetDayViewModel()
        {
            Day = DateTime.Now;
            TimeSheetLine = new List<TimeSheetLineViewModel>();
            Project = new List<ProjectViewModel>();
            Hours = new List<KeyValuePair<string, TimeSpan>>();
        }

        public TimeSheetDayViewModel(DateTime day)
        {
            Day = day;
            TimeSheetLine = new List<TimeSheetLineViewModel>();
            Project = new List<ProjectViewModel>();
            Hours = new List<KeyValuePair<string, TimeSpan>>();
        }
    }
}