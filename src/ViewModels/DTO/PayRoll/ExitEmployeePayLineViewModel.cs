using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ExitEmployeePayLineViewModel : GenericViewModel
    {
        public string Details { get; set; }
        public DateTime Month { get; set; }
        public double? NumberDayWorked { get; set; }
        public int IdExitEmployee { get; set; }
        public int? State { get; set; }
        public string DeletedToken { get; set; }
        public IDictionary<string, double> RuleListAndValues { get; set; }

        public ExitEmployeeViewModel IdExitEmployeeNavigation { get; set; }
        public ICollection<ExitEmployeePayLineSalaryRuleViewModel> ExitEmployeePayLineSalaryRule { get; set; }
    }
}
