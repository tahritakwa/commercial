using Utils.Utilities.DataUtilities;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.PayRoll
{
    public class LeaveBalanceRemainingViewModel : GenericViewModel
    {
        public int IdEmployee { get; set; }
        public int IdLeaveType { get; set; }
        public DayHour CumulativeTaken { get; set; }
        public DayHour RemainingBalance { get; set; }
        public DayHour CumulativeAcquired { get; set; }
        public string DeletedToken { get; set; }
        public virtual EmployeeViewModel IdEmployeeNavigation { get; set; }
        public virtual LeaveTypeViewModel IdLeaveTypeNavigation { get; set; }
    }
}
