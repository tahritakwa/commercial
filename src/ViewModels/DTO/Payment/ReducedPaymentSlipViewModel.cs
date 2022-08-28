using System;

namespace ViewModels.DTO.Payment
{
    public class ReducedPaymentSlipViewModel
    {
        public int Id { get; set; }
        public string Reference { get; set; }
        public string Agency { get; set; }
        public string Deposer { get; set; }
        public DateTime Date { get; set; }
        public double? TotalAmountWithNumbers { get; set; }
        public int? State { get; set; }
        public string BankName { get; set; }
    }
}