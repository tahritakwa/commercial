using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.PayRoll
{
    public class LoanViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public int? State { get; set; }
        public DateTime? ApprouvementDate { get; set; }
        public DateTime? DisbursementDate { get; set; }
        public string DeletedToken { get; set; }
        public int IdEmployee { get; set; }
        public double Amount { get; set; }
        public DateTime ObtainingDate { get; set; }
        public string Reason { get; set; }
        public string LoanAttachementFile { get; set; }
        public int CreditType { get; set; }
        public IList<FileInfoViewModel> LoanFileInfo { get; set; }
        public int MonthsNumber { get; set; }
        public DateTime? RefundStartDate { get; set; }
        public virtual EmployeeViewModel IdEmployeeNavigation { get; set; }
        public virtual ICollection<LoanInstallmentViewModel> LoanInstallment { get; set; }
        public virtual ICollection<PayslipDetailsViewModel> PayslipDetails { get; set; }
    }
}
