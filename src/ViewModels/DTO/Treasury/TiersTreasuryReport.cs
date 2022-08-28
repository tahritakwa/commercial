namespace ViewModels.DTO.Treasury
{
    public class TiersTreasuryReport
    {
        public int IdTiers { get; set; }
        public string TiersName { get; set; }
        public string CodeTiers { get; set; }
        public string CurrencyCode { get; set; }
        public int CurrencyPrecision { get; set; }
        public double TotalAmount { get; set; }
        public double TotalAmountWithCurrency { get; set; }
        public double TotalOverduePaymentAmount { get; set; }
        public double TotalOverduePaymentAmountWithCurrency { get; set; }

        public double TotalTurnover { get; set; }
        public double TotalTurnoverWithCurrency { get; set; }

    }
}
