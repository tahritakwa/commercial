using ModelView.Reporting.Generic;
using System;
using System.Collections.Generic;
using System.Text;

namespace ModelView.Reporting
{
    public class StockMovementInformationViewModel : ReportCompanyInformationViewModel
    {
        public string DocumentDate { get; set; }
        public string WarehouseSource { get; set; }
        public string WarehouseDestination { get; set; }
        public string Code { get; set; }
        public string Status { get; set; }

        public StockMovementInformationViewModel(ReportCompanyInformationViewModel reportCompanyInformationViewModel)
        {
            CompanyName = reportCompanyInformationViewModel.CompanyName;
            CompanyAdress = reportCompanyInformationViewModel.CompanyAdress;
            CompanyEmail = reportCompanyInformationViewModel.CompanyEmail;
            CompanyWebSite = reportCompanyInformationViewModel.CompanyWebSite;
            CompanyCountry = reportCompanyInformationViewModel.CompanyCountry;
            CompanyCity = reportCompanyInformationViewModel.CompanyCity;
            CompanyZipCode = reportCompanyInformationViewModel.CompanyZipCode;
            CompanyTel = reportCompanyInformationViewModel.CompanyTel;
            CompanyCommercialRegister = reportCompanyInformationViewModel.CompanyCommercialRegister;
            CompanySiret = reportCompanyInformationViewModel.CompanySiret;
            StarkWebSiteUrl = reportCompanyInformationViewModel.StarkWebSiteUrl;
            StarkLogo = reportCompanyInformationViewModel.StarkLogo;
            CompanyLogo = reportCompanyInformationViewModel.CompanyLogo;
            CompanyMatriculeFisc = reportCompanyInformationViewModel.CompanyMatriculeFisc;
            CompanyCnssAffiliation = reportCompanyInformationViewModel.CompanyCnssAffiliation;
            CompanyCurrency = reportCompanyInformationViewModel.CompanyCurrency;
        }
    }

    public class ReportStockMovementViewModel
    {
        public string Item { get; set; }
        public string Quantity { get; set; }
    }
}
