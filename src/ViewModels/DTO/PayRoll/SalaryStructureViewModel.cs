using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.PayRoll
{
    public class SalaryStructureViewModel : GenericViewModel
    {
        public string SalaryStructureReference { get; set; }
        public string Name { get; set; }
        public int Order { get; set; }
        public string DeletedToken { get; set; }
        public int? IdParent { get; set; }
        public string Description { get; set; }
        /// <summary>
        /// To memorize the minimum start date of the periodicity in order to carry out checks
        /// </summary>
        public DateTime StartDate { get; set; }
        public SalaryStructureViewModel IdParentNavigation { get; set; }

        public ICollection<ContractViewModel> Contract { get; set; }
        public ICollection<SalaryStructureSalaryRuleViewModel> SalaryStructureSalaryRule { get; set; }
        public ICollection<OfferViewModel> Offer { get; set; }
        public ICollection<SalaryRuleViewModel> SalaryRules { get; set; }
        public virtual ICollection<SalaryStructureValidityPeriodViewModel> SalaryStructureValidityPeriod { get; set; }


    }
}
