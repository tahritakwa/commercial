namespace ViewModels.DTO.Reporting
{
    public class StockValuationReportLinesViewModel
    {
        public string CodeArticle { get; set; }
        public string Shelf { get; set; }
        public string Storage { get; set; }
        public string Article { get; set; }
        public string TotalQuantity { get; set; }
        public double? UnitPurchasePrice { get; set; }
        public double? Total { get; set; }
        public string Currency { get; set; }
        public int Precision { get; set; }
        public double UnitPurchasePriceWithCurrency { get; set; }
        public string UnitPurchasePriceStringWithCurrency { get; set; }
        public double TotalWithCurrency { get; set; }
        public string TotalStringWithCurrency { get; set; }
    }
}
