using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public class LeaveBalanceRemainingLine
    {
        public EmployeeViewModel Employee { get; set; }
        public ICollection<LeaveBalanceRemainingViewModel> leaveBalanceRemainingList { get; set; }

    }
}
