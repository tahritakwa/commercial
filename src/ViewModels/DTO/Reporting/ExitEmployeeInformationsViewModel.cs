using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    public class ExitEmployeeInformationsViewModel : ReportCompanyInformationViewModel
    {
        public string EmployeeFullName { get; set; }
        public string Email { get; set; }
        public string ExitPhysicalDate { get; set; }
        public string HiringDate { get; set; }
        public string Label { get; set; }
        public string Rib { get; set; }
        public string BankName { get; set; }


        public ExitEmployeeInformationsViewModel(ReportCompanyInformationViewModel reportCompanyInformationViewModel)
        {
            CompanyName = reportCompanyInformationViewModel.CompanyName ;
            CompanyAdress = reportCompanyInformationViewModel.CompanyAdress ;
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
            VatNumber = reportCompanyInformationViewModel.VatNumber;
        }

    }
}
