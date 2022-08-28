using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Reporting.Treasury
{
    public class SettlementWithholdingTaxViewModel
    {
        public string WithholdingTaxConfigName { get; set; }
        public string TotalAmount { get; set; }
        public string WithholdingTaxAmount { get; set; }
        public string PaidAmount { get; set; }
    }
}
