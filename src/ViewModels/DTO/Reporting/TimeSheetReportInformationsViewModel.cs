using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    public class TimeSheetReportInformationsViewModel : ReportCompanyInformationViewModel
    {
        //TimeSheet
        public string ProjectName { get; set; }
        public string EmployeeFullName { get; set; }
        public string ClientFullName { get; set; }
        public string ContactFullName { get; set; }
        public string ContactEMail { get; set; }
        public string Month { get; set; }
        public double NumberOfWorkedDays { get; set; }
        public double NumberOfWorkedHours { get; set; }
        public double NumberOfLeaveDays { get; set; }
        public double NumberOfLeaveHours { get; set; }
        public double NumberOfDayOffDays { get; set; }
        public double NumberOfDayOffHours { get; set; }
        public string Rib { get; set; }
        public string BankName { get; set; }

        public TimeSheetReportInformationsViewModel(ReportCompanyInformationViewModel reportCompanyInformationViewModel)
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
            VatNumber = reportCompanyInformationViewModel.VatNumber;
        }
    }
}
