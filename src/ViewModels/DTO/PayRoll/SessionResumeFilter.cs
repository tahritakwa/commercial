using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public class SessionResumeFilter
    {
        public int IdSession { get; set; }
        public IList<int> EmployeesId { get; set; }
        public int Page { get; set; }
        public int PageSize { get; set; }
        public IList<PayslipDetailsViewModel> PayslipDetails { get; set; }
    }
}
