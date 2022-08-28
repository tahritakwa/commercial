using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.PayRoll
{
    public class BenefitInKindViewModel : GenericViewModel
    {
        public string Name { get; set; }
        public int? IdCnss { get; set; }
        public string Description { get; set; }
        public string DeletedToken { get; set; }
        public string Code { get; set; }
        public bool IsTaxable { get; set; }
        public bool DependNumberDaysWorked { get; set; }

        public CnssViewModel IdCnssNavigation { get; set; }
        public ICollection<ContractBenefitInKindViewModel> ContractBenefitInKind { get; set; }
        public ICollection<OfferBenefitInKindViewModel> OfferBenefitInKind { get; set; }
    }
}
