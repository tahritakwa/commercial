using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public class LeaveBalanceRemainingFilter
    {
        public int LeaveTypeId { get; set; }
        public List<int> EmployeesId { get; set; }
        public int Page { get; set; }
        public int PageSize { get; set; }
    }
}
