using System;

namespace ViewModels.DTO.Accounting
{
    public class FiltreSettlement
    {
        public string SettlementCode { get; set; }
        public string TierName { get; set; }
        public double? Amount { get; set; }
        public DateTime? SettlementDate { get; set; }
        public string BankName { get; set; }
        public string PaymentMethod { get; set; }
    }

    public class SettlementAccountingModel
    {
        public FiltreSettlement FiltreSettlement { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public int Type { get; set; }
        public bool? IsAccounted { get; set; }
        public int Page { get; set; }
        public int PageSize { get; set; }
    }
}
