using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class SalaryStructureSalaryRuleViewModel : GenericViewModel
    {
        public int IdSalaryStructure { get; set; }
        public int IdSalaryRule { get; set; }
        public string DeletedToken { get; set; }

        public SalaryRuleViewModel IdRuleNavigation { get; set; }
        public SalaryStructureViewModel IdStructureNavigation { get; set; }
    }
}
