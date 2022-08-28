using System;

namespace ViewModels.DTO.Dashboard
{
    public class ChartDataElement
    {
        public byte PeriodEnum { get; set; }
        public string Period { get; set; }
        public DateTime StartPeriod { get; set; }
        public DateTime EndPeriod { get; set; }
        public int IdTiers { get; set; }
        public string TiersName { get; set; }
        public string TiersCode { get; set; }
        public double HTAmount { get; set; }
        public double TTCAmount { get; set; }
        public int Quantity { get; set; }
        public string Type { get; set; }
        public int RankByTTCAmount { get; set; }
        public int RankByQuantity { get; set; }
        public int IdItem { get; set; }
        public string Description { get; set; }
        public string ItemDescription { get; set; }
        public string ItemCode { get; set; }
        public string Name { get; set; }
        public string SupplierName { get; set; }
        public double Amount { get; set; }
        public string StockUnit { get; set; }
        public int AvailableQuantity { get; set; }
        public int IdOrder { get; set; }
        public string OrderCode { get; set; }
        public dynamic HtAmountFormatOption { get; set; }
        public int Status { get; set; }
        public double HtTotalPerItem { get; set; }
        public double QuantityPerItem { get; set; }
        public string LabelItemFamily { get; set; }
        public string OperationType { get; set; }
        public int RankByAmount { get; set; }
        public double QuantityPerItemFamily { get; set; }
        public string ItemFamily { get; set; }
        public long RankByFamilyPerAmount { get; set; }
        public long RankByFamilyPerQuantity { get; set; }
        public double InvoiceAmountHT { get; set; }
        public double InvoiceAmountTTC { get; set; }
        public int Month { get; set; }
        public int Year { get; set; }
        public double InvoiceRemainingAmount { get; set; }
        public double HtTotalPerItemFamily { get; set; }
        public string EmployeeName { get; set; }
        public double TotalWorkDays { get; set; }
        public double TotalDayOff { get; set; }
        public DateTime DocumentDate { get; set; }
        public int IdStatus { get; set; }
        public string DocumentStatus { get; set; }
        public double HtAmount { get; set; }
        public long Rank { get; set; }
        public int TotalCommanded { get; set; }
        public int TotalDelivred { get; set; }
        public double DeliveryRate { get; set; }
        public int DocumentMonth { get; set; }
        public int DocumentYear { get; set; }
        public double YTDInvoiceAmountHT { get; set; }
        public double YTDInvoiceAmountTTC { get; set; }
        public double LYTDInvoiceAmountHT { get; set; }
        public double LYTDInvoiceAmountTTC { get; set; }
        public int IdTier { get; set; }
    }
}
