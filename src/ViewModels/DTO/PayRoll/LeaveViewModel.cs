using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.PayRoll
{
    public class LeaveViewModel : GenericViewModel
    {

        public DateTime CreationDate { get; set; }
        public DateTime? TreatmentDate { get; set; }
        public int? TreatedBy { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public DayHour NumberDaysLeave { get; set; }
        public DayHour TotalLeaveBalanceAcquired { get; set; }
        public DayHour PreviousYearTotalLeaveBalanceAcquired { get; set; }
        public DayHour CurrentYearTotalLeaveBalanceAcquired { get; set; }
        public DayHour CurrentBalance { get; set; }
        public DayHour PreviousYearCurrentBalance { get; set; }
        public DayHour CurrentYearCurrentBalance { get; set; }
        public DayHour LeaveBalanceRemaining { get; set; }
        public DayHour PreviousYearLeaveRemaining { get; set; }
        public DayHour CurrentYearLeaveRemaining { get; set; }
        public string Description { get; set; }
        public IList<FileInfoViewModel> LeaveFileInfo { get; set; }
        public string LeaveAttachementFile { get; set; }
        public int IdEmployee { get; set; }
        public int IdLeaveType { get; set; }
        public int Status { get; set; }
        public string DeletedToken { get; set; }

        public EmployeeViewModel TreatedByNavigation { get; set; }
        public virtual EmployeeViewModel IdEmployeeNavigation { get; set; }
        public virtual LeaveTypeViewModel IdLeaveTypeNavigation { get; set; }
        public virtual IList<CommentViewModel> Comments { get; set; }
        public string Code { get; set; }
        public bool IsExceeded { get; set; }
        public bool IsConnectedUserInHierarchy { get; set; }

    }
}
