using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting.Treasury
{
    public class SettlementInformationViewModel
    {
        public string Client { get; set; }
        public string Code { get; set; }
        public string TotalAmount { get; set; }
        public string SettlementMode { get; set; }
        public string Date { get; set; }
        public string StarkWebSiteUrl { get; set; }
        public string StarkLogo { get; set; }
        public string CurrencyCode { get; set; }
        public string SettlementTitleFR { get; set; }
        public string SettlementTitleEN { get; set; }

        public string Rib { get; set; }
        public string BankName { get; set; }
        public ReportCompanyInformationViewModel Company { get; set; }

    }
}
