using System;

namespace ViewModels.DTO.Reporting
{
    [Serializable]
    public class ReportSalaryRuleLineViewModel
    {
        public string BaseSalary { get; set; }
        public string GrossSalary { get; set; }
        public string SocialContribution { get; set; }
        public string TaxableWages { get; set; }
        public string Irpp { get; set; }
        public string Css { get; set; }
        public string NetSalary { get; set; }
    }
}
