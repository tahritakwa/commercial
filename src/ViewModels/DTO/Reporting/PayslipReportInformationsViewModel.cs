using System;
using System.Collections.Generic;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    public class PayslipReportInformationsViewModel: ReportCompanyInformationViewModel
    {
        // Payslip informations
        public string NumberOfDaysWorked { get; set; }
        public DateTime Month { get; set; }
        public string SalaryOfMonth { get; set; }
        public double NetToPay { get; set; }
        // Employee Informations
        public string EmployeeFullName { get; set; }
        public string EmployeeRegistrationNumber { get; set; }
        public string EmployeeCnss { get; set; }
        public string EmployeeAdress { get; set; }
        public string EmployeeContractType { get; set; }
        public string EmployeeHiringDate { get; set; }
        public string EmployeeIdentityPiece { get; set; }
        public string EmployeeJob { get; set; }
        public bool EmployeeIsForeign { get; set; }
        public string EmployeeGrade { get; set; }
        public string EmployeeBaseSalary { get; set; }
        public bool EmployeeFamilyLeader { get; set; }
        public string EmployeeEchellon { get; set; }
        public string EmployeePaidLeave { get; set; }
        public string EmployeeUnPaidLeave { get; set; }
        public int EmployeeChildreenNumber { get; set; }
        public string EmployeeCategory { get; set; }
        // Maximum number of days allowed for the current pay month
        public double NumberOfDaysWorkedByCompanyInMonth { get; set; }
        // To identify the contract for which we are doing the preview
        public int IdContract { get; set; }
        public string Rib { get; set; }
        public string BankName { get; set; }
        // Payslip salary rule lines
        public IList<PayslipReportLinesViewModel> PayslipReportLinesViewModels { get; set; }

        public PayslipReportInformationsViewModel(ReportCompanyInformationViewModel reportCompanyInformationViewModel)
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
            CompanyCurrency = reportCompanyInformationViewModel.CompanyCurrency;
            CompanyCnssAffiliation = reportCompanyInformationViewModel.CompanyCnssAffiliation;
            CompanyMatriculeFisc = reportCompanyInformationViewModel.CompanyMatriculeFisc;
            CompanySiret = reportCompanyInformationViewModel.CompanySiret;
            VatNumber = reportCompanyInformationViewModel.VatNumber;
            PayslipReportLinesViewModels = new List<PayslipReportLinesViewModel>();
        }
    }
}
