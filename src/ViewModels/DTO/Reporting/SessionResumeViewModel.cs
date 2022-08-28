using System;

namespace ViewModels.DTO.Reporting
{
    [Serializable]
    public class SessionResumeLineViewModel : ReportSalaryRuleLineViewModel
    {
        public string Matricule { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string ContractType { get; set; }
        public string NumberDaysWorked { get; set; }
        public string NumberDaysPaidLeave { get; set; }
    }
}
