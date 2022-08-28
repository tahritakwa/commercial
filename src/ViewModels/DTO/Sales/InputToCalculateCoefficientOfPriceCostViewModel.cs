using System;

namespace ViewModels.DTO.Sales
{
    public class InputToCalculateCoefficientOfPriceCostViewModel
    {
        public double TotalDocumentPrice { get; set; }
        public double TotalDocumentTtcPrice { get; set; }
        public double TotalExpensePrice { get; set; }
        public double? HtAmountLineWithCurrency { get; set; }
        public double? HtAmountLineWithCurrencyPercentage { get; set; }
        public int IdCurrency { get; set; }
        public int IdDocument { get; set; }
        public double? Margin { get; set; } = 0;
        public DateTime DocumentDate { get; set; }
    }
}
