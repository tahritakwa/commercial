using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public class ConstantRateViewModel : RuleUniqueReferenceViewModel
    {
        public string Description { get; set; }
        public int IdRuleUniqueReference { get; set; }

        public RuleUniqueReferenceViewModel IdRuleUniqueReferenceNavigation { get; set; }
        public ICollection<ConstantRateValidityPeriodViewModel> ConstantRateValidityPeriod { get; set; }
    }
}
