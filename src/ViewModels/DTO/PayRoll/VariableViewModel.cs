using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public class VariableViewModel : RuleUniqueReferenceViewModel
    {
        public string Description { get; set; }
        public string Formule { get; set; }
        public int IdRuleUniqueReference { get; set; }
        public string Name { get; set; }
        public bool UpdatePayslip { get; set; }
        public RuleUniqueReferenceViewModel IdRuleUniqueReferenceNavigation { get; set; }
        public ICollection<VariableValidityPeriodViewModel> VariableValidityPeriod { get; set; }

    }
}
