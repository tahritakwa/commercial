using System;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    [Serializable]
    public class TransferOrderReportInformationsViewModel : ReportCompanyInformationViewModel
    {       
        // Transfer order infos
        public DateTime Date { get; set; }
        public string SessionMonth { get; set; }
        public string Label { get; set; }
        public double Total { get; set; }
        // Bank account
        public string RibCompany { get; set; }
        public string BankName { get; set; }
        public string Rib { get; set; }
        public TransferOrderReportInformationsViewModel(ReportCompanyInformationViewModel reportCompanyInformationViewModel)
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
        }
    }
}
