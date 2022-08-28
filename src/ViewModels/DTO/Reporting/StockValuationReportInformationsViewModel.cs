using System;
using System.Collections.Generic;
using System.Text;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    public class StockValuationReportInformationsViewModel
    {
        //WareHouse
        public string WarehouseName { get; set; }

        //Company
        public string StarkWebSiteUrl { get; set; }
        public string StarkLogo { get; set; }
        public string CompanyLogo { get; set; }
        public string Rib { get; set; }
        public string BankName { get; set; }
        public ReportCompanyInformationViewModel Company { get; set; }
    }
}
