using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Reporting.Treasury
{
    public class PaymentSlipReportInfoViewModel
    {
        public string Reference { get; set; }
        public string Agency { get; set; }
        public string PaymentSlipDate { get; set; }
        public string SocialReason { get; set; }
        public string RIB { get; set; }
        public int NumberOfSettlement { get; set; }
        public double TotalAmountWithNumbers { get; set; }
        public string TotalAmountWithLetters { get; set; }
    }
}
