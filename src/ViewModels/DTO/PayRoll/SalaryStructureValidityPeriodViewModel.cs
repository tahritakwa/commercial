using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class SalaryStructureValidityPeriodViewModel : GenericViewModel
    {
        public DateTime StartDate { get; set; }
        public int IdSalaryStructure { get; set; }
        public int? State { get; set; }
        public string DeletedToken { get; set; }

        public virtual SalaryStructureViewModel IdSalaryStructureNavigation { get; set; }
        public virtual ICollection<SalaryStructureValidityPeriodSalaryRuleViewModel> SalaryStructureValidityPeriodSalaryRule { get; set; }
        public virtual ICollection<SalaryRuleViewModel> SalaryRule { get; set; }

    }
}
