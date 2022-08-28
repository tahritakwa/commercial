using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.PayRoll
{
    public class TransferOrderViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Title { get; set; }
        public int IdBankAccount { get; set; }
        public DateTime Month { get; set; }
        public double TotalAmount { get; set; }
        public DateTime CreationDate { get; set; }
        public string DeletedToken { get; set; }
        public int State { get; set; }

        public ICollection<int> IdEmployeeSelected { get; set; }
        public virtual BankAccountViewModel IdBankAccountNavigation { get; set; }
        public virtual ICollection<TransferOrderDetailsViewModel> TransferOrderDetails { get; set; }
        public ICollection<TransferOrderSessionViewModel> TransferOrderSession { get; set; }
        public ICollection<PayslipViewModel> Payslip { get; set; }
    }
}
