using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class SalaryStructureValidityPeriodSalaryRuleViewModel : GenericViewModel
    {
        public string DeletedToken { get; set; }
        public int IdSalaryRule { get; set; }
        public int IdSalaryStructureValidityPeriod { get; set; }
        public bool Checked { get; set; }

        public virtual SalaryRuleViewModel IdSalaryRuleNavigation { get; set; }
        public virtual SalaryStructureValidityPeriodViewModel IdSalaryStructureValidityPeriodNavigation { get; set; }
    }
}
