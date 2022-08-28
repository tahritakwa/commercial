using System;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class TimeSheetLineViewModel : GenericViewModel
    {
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public int? IdProject { get; set; }
        public string Details { get; set; }
        public DateTime Day { get; set; }
        public int IdTimeSheet { get; set; }
        public string DeletedToken { get; set; }
        public bool Valid { get; set; }
        public DayHour DayHour { get; set; }
        public int? IdDayOff { get; set; }
        public int? IdLeave { get; set; }
        public bool? Worked { get; set; }
        public string WaitingLeaveTypeName { get; set; }

        public virtual LeaveViewModel IdLeaveNavigation { get; set; }
        public DayOffViewModel IdDayOffNavigation { get; set; }
        public ProjectViewModel IdProjectNavigation { get; set; }
        public TimeSheetViewModel IdTimeSheetNavigation { get; set; }
    }
}