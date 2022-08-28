using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class OfferBenefitInKindViewModel : GenericViewModel
    {
        public int IdOffer { get; set; }
        public int IdBenefitInKind { get; set; }
        public DateTime ValidityStartDate { get; set; }
        public DateTime? ValidityEndDate { get; set; }
        public double Value { get; set; }
        public string DeletedToken { get; set; }

        public BenefitInKindViewModel IdBenefitInKindNavigation { get; set; }
        public OfferViewModel IdOfferNavigation { get; set; }
    }
}
