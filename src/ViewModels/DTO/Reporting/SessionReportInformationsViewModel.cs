using System;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    [Serializable]
    public class SessionReportInformationsViewModel : ReportCompanyInformationViewModel
    {
        public string Code { get; set; }
        public string Title { get; set; }
        public string Month { get; set; }
        public string Year { get; set; }
        public string Rib { get; set; }
        public string BankName { get; set; }

        public SessionReportInformationsViewModel(ReportCompanyInformationViewModel reportCompanyInformationViewModel)
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
            StarkWebSiteUrl = reportCompanyInformationViewModel.StarkWebSiteUrl;
            StarkLogo = reportCompanyInformationViewModel.StarkLogo;
            CompanyLogo = reportCompanyInformationViewModel.CompanyLogo;
            CompanyMatriculeFisc = reportCompanyInformationViewModel.CompanyMatriculeFisc;
            CompanyCnssAffiliation = reportCompanyInformationViewModel.CompanyCnssAffiliation;
            CompanyCurrency = reportCompanyInformationViewModel.CompanyCurrency;
            VatNumber = reportCompanyInformationViewModel.VatNumber;
            CompanySiret = reportCompanyInformationViewModel.CompanySiret;
        }
    }
}
