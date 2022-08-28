namespace ViewModels.DTO.Treasury
{
    public class TiersTreasuryReportForExportViewModel
    {
        public int IdTiers { get; set; }
        public string TiersName { get; set; }
        public string CodeTiers { get; set; }
        public string CurrencyCode { get; set; }
        public int CurrencyPrecision { get; set; }
        public string TotalAmount { get; set; }
        public string TotalAmountWithCurrency { get; set; }
        public string TotalOverduePaymentAmount { get; set; }
        public string TotalOverduePaymentAmountWithCurrency { get; set; }

        public string TotalTurnover { get; set; }
        public string TotalTurnoverWithCurrency { get; set; }

        public TiersTreasuryReportForExportViewModel()
        {

        }

        public TiersTreasuryReportForExportViewModel(TiersTreasuryReport model)
        {
            IdTiers = model.IdTiers;
            TiersName = model.TiersName;
            CodeTiers = model.CodeTiers;
            CurrencyCode = model.CurrencyCode;
            CurrencyPrecision = model.CurrencyPrecision;
        }

    }
}
