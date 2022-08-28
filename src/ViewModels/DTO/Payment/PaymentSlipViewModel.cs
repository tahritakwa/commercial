using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Payment
{
    public class PaymentSlipViewModel : GenericViewModel
    {
        public PaymentSlipViewModel()
        {
            Settlement = new HashSet<SettlementViewModel>();
        }
        public string Reference { get; set; }
        public string Agency { get; set; }
        public string Deposer { get; set; }
        public DateTime Date { get; set; }
        public int? IdBankAccount { get; set; }
        public double? TotalAmountWithNumbers { get; set; }
        public string TotalAmountWithLetters { get; set; }
        public int? State { get; set; }
        public string Type { get; set; }
        public string DeletedToken { get; set; }
        public BankAccountViewModel IdBankAccountNavigation { get; set; }
        public ICollection<SettlementViewModel> Settlement { get; set; }
    }
}