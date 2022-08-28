using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class SalaryRuleValidityPeriodViewModel : GenericViewModel
    {
        public DateTime StartDate { get; set; }
        public int? State { get; set; }
        public string Rule { get; set; }
        public int IdSalaryRule { get; set; }
        public string DeletedToken { get; set; }

        public virtual SalaryRuleViewModel IdSalaryRuleNavigation { get; set; }
        public ICollection<SalaryRuleViewModel> SalaryRules { get; set; }

    }
}
