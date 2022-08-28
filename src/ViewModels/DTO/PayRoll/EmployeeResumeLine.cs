using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public class EmployeeResumeLine
    {
        public ContractViewModel IdContractNavigation { get; set; }
        public AttendanceViewModel IdAttendanceNavigation { get; set; }
        public IDictionary<int, string> RuleListAndValues { get; set; }
    }
}
