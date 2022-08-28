using System;

namespace ViewModels.DTO.Dashboard
{
    public class SalesPurchasesStateDataElement
    {
        public double InvoiceAmountHT { get; set; }
        public double InvoiceAmountTTC { get; set; }
        public double InvoiceRemainingAmount { get; set; }
        public int Month { get; set; }
        public int Year { get; set; }
        public string Type { get; set; }
        public byte PeriodEnum { get; set; }
        public string Period { get; set; }
        public DateTime StartPeriod { get; set; }
        public DateTime EndPeriod { get; set; }
        public double YTDInvoiceAmountHT { get; set; }
        public double YTDInvoiceAmountTTC { get; set; }
        public double LYTDInvoiceAmountHT { get; set; }
        public double LYTDInvoiceAmountTTC { get; set; }






    }
}
