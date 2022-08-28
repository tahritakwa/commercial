using System;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.PayRoll
{
    public class ExitEmployeeLeaveLineViewModel : GenericViewModel
    {
        public string Details { get; set; }
        public DateTime Month { get; set; }
        public string MonthString { get; set; }
        public int? IdExitEmployee { get; set; }
        public string DayTakenPerMonth { get; set; }
        public DayHour TotalDayHourTakenPerMonth { get; set; }
        public double LastNumberOfHourPerDay { get; set; }
        public double TotalTakenPerMonth { get; set; }
        public int AcquiredParMonth { get; set; }
        public int? IdLeaveType { get; set; }
        public double CumulativeTaken { get; set; }
        public double CumulativeAcquired { get; set; }
        public double BalancePerMonth { get; set; }
        public double TotalTakenPerYear { get; set; }
        public double AcquiredPerYear { get; set; }
        public int Year { get; set; }
        public double BalancePerYear { get; set; }
        public string DayTakenPerYear { get; set; }

        public ExitEmployeeViewModel IdExitEmployeeNavigation { get; set; }
        public LeaveTypeViewModel IdLeaveTypeNavigation { get; set; }
    }
}
