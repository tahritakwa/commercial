using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class LeaveTypeViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public bool Paid { get; set; }
        public bool RequiredDocument { get; set; }
        public bool Calendar { get; set; }
        public int MaximumNumberOfDays { get; set; }
        public string DeletedToken { get; set; }
        public string Description { get; set; }
        public bool Cumulable { get; set; }
        public bool AuthorizedOvertaking { get; set; }
        public int Period { get; set; }
        public DateTime? ExpiryDate { get; set; }
        public bool Worked { get; set; }
        public virtual ICollection<LeaveBalanceRemainingViewModel> LeaveBalanceRemaining { get; set; }
    }
}
