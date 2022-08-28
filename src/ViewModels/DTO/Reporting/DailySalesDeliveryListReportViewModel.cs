using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Reporting
{
    public class DailySalesDeliveryListReportViewModel
    {
        public string CustomerCode { get; set; }
        public string CustomerName { get; set; }
        public string BLCode { get; set; }
        public DateTime? BLDate { get; set; }
        public string BLDateString { get; set; }
        public double? TotalDebit { get; set; }
        public double? TotalCredit { get; set; }
        public string TotalDebitString { get; set; }
        public string TotalCreditString { get; set; }
    }
}
