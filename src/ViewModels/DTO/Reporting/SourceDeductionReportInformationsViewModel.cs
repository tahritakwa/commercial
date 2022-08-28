namespace ViewModels.DTO.Reporting
{
    public class SourceDeductionReportInformationsViewModel
    {
        //Company
        public string CompanyMatriculeFisc { get; set; }
        public string CompanyTaxIdentNumber { get; set; }
        public string CompanyCategory { get; set; }
        public string CompanyName { get; set; }
        public string CompanyAdress { get; set; }
        public string CompanyEmail { get; set; }
        public string CompanyWebSite { get; set; }
        public string CompanyTel { get; set; }
        public string CompanySecondaryEstablishment { get; set; }
        public string CompanyCountry { get; set; }
        public string CompanyCity { get; set; }
        public string CompanyZipCode { get; set; }
        public string CompanyCommercialRegister { get; set; }
        public string CompanySiret { get; set; }
        public string StarkWebSiteUrl { get; set; }
        public string StarkLogo { get; set; }
        public string CompanyLogo { get; set; }

        //Employee
        public string EmployeeMatricule { get; set; }
        public string EmployeeFullName { get; set; }
        public string EmployeeMaritalStatus { get; set; }
        public string EmployeeAdress { get; set; }
        public string EmployeeJob { get; set; }
        public string EmployeeCIN { get; set; }
        public string EmployeeMatriculeCNSS { get; set; }
        public int EmployeePeriodWorked { get; set; }
        public int EmployeeChildrenNumber { get; set; }

        //SourceDeductionDetails
        public int Year { get; set; }
        public double Taxableages { get; set; }
        public double NaturalAdvantage { get; set; }
        public double GrossTaxable { get; set; }
        public double RetainedReinvested { get; set; }
        public double SumIrpp { get; set; }
        public double CSS { get; set; }
        public double NetToPay { get; set; }
        public string GenerationDate { get; set; }
    }
}
