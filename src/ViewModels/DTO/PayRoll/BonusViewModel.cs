using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.PayRoll
{
    public class BonusViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public bool IsFixe { get; set; }
        public int IdCnss { get; set; }
        public bool IsTaxable { get; set; }
        public bool DependNumberDaysWorked { get; set; }
        public string DeletedToken { get; set; }
        /// <summary>
        /// To memorize the minimum start date of the periodicity in order to carry out checks
        /// </summary>
        public DateTime StartDate { get; set; }
        public CnssViewModel IdCnssNavigation { get; set; }
        public bool UpdatePayslip { get; set; }
        public ICollection<BonusValidityPeriodViewModel> BonusValidityPeriod { get; set; }
        public ICollection<ContractBonusViewModel> ContractBonus { get; set; }
        public ICollection<SessionBonusViewModel> SessionBonus { get; set; }
        public ICollection<OfferBonusViewModel> OfferBonus { get; set; }
    }
}
