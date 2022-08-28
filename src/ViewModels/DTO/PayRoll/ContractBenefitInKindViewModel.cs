using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ContractBenefitInKindViewModel : GenericViewModel
    {
        public int IdContract { get; set; }
        public int IdBenefitInKind { get; set; }
        public DateTime ValidityStartDate { get; set; }
        public DateTime? ValidityEndDate { get; set; }
        public double Value { get; set; }
        public string DeletedToken { get; set; }
        public int? State { get; set; }
        public bool CoversWholeMonth { get; set; }

        public virtual BenefitInKindViewModel IdBenefitInKindNavigation { get; set; }
        public virtual ContractViewModel IdContractNavigation { get; set; }
    }
}
