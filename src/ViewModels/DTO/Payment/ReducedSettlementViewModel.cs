using System;

namespace ViewModels.DTO.Payment
{
    public class ReducedSettlementViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public int Direction { get; set; }
        public string IssuingBank { get; set; }
        public string Holder { get; set; }
        public string SettlementReference { get; set; }
        public DateTime SettlementDate { get; set; }
        public DateTime? CommitmentDate { get; set; }
        public int? IdPaymentStatus { get; set; }
        public double AmountWithCurrency { get; set; }
        public string PaymentSlipReference { get; set; }
        public DateTime? PaymentSlipReconciliationDate { get; set; }
        public int Precision { get; set; }
        public string CurrencyCode { get; set; }
        public string TiersName { get; set; }
        public int IdTypeTiers { get; set; }

    }
}
