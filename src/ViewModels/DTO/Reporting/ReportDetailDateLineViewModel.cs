using System;

namespace ViewModels.DTO.Reporting
{
    [Serializable]
    public class ReportDetailDateLineViewModel : ReportSalaryRuleLineViewModel
    {
        public DateTime Month { get; set; }
        public string MonthString { get; set; }
        public string Details { get; set; }
    }
}
