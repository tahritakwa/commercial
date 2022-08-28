using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Reporting.Treasury
{
    public class WithholdingTaxReportInfoViewModel
    {
        public string Date { get; set; }
        public int Year { get; set; }
        public string Code { get; set; }
        public string InvoicesCodes { get; set; }
        public TiersWithholdingTaxViewModel PayingAgency { get; set; }
        public TiersWithholdingTaxViewModel Beneficiary{ get; set; }
    } 
}
