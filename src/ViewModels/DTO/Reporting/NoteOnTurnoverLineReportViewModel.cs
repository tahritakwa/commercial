using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.Reporting
{
    public class NoteOnTurnoverLineReportViewModel
    {
        public string CodeItem { get; set; }
        public string Quantity { get; set; }
        public string Cost { get; set; }
        public string SalePriceAfterDelivery { get; set; }
        public string Margin { get; set; }
        public string Designation { get; set; }
        public string CurrencyCode { get; set; }
        public string CodeInvoiceSales { get; set; }
        public double? GainInAmountHT { get; set; }
        public double? TotalSales { get; set; }
        public double? TotalPurchase { get; set; }
    }
}
