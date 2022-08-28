using System;
using System.Collections.Generic;
using System.Text;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    public class VatDeclarationInformationsViewModel
    {
        //VAT
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string StarkWebSiteUrl { get; set; }
        public string StarkLogo { get; set; }
        public string Rib { get; set; }
        public string BankName { get; set; }
        public string Currency { get; set; }

        public ReportCompanyInformationViewModel Company { get; set; }
    }
}
