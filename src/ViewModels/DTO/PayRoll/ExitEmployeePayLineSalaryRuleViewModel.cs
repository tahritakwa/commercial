using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ExitEmployeePayLineSalaryRuleViewModel : GenericViewModel
    {
        public int? IdSalaryRule { get; set; }
        public int? IdExitEmployeePayLine { get; set; }
        public double Value { get; set; }

        public SalaryRuleViewModel IdSalaryRuleNavigation { get; set; }
        public ExitEmployeePayLineViewModel IdExitEmployeePayLineNavigation { get; set; }
    }
}
