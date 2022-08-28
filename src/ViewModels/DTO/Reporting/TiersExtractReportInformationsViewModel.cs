using System;
using System.Collections.Generic;
using System.Text;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    public class TiersExtractReportInformationsViewModel
    {
        //Tiers
        public string ReportTitle { get; set; }
        public string TiersName { get; set; }
        public int TiersType { get; set; }
        public string StartDate { get; set; }
        public string DateNow { get; set; }
        public string BalanceAtStartDate { get; set; }
        public string BalanceAtDateNow { get; set; }
        public string StarkWebSiteUrl { get; set; }
        public string StarkLogo { get; set; }
        public string SymboleCurrency { get; set; }
        public string Rib { get; set; }
        public string BankName { get; set; }

        public ReportCompanyInformationViewModel Company { get; set; }
    }
}
