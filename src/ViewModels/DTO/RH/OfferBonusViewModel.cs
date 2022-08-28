using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.PayRoll;

namespace ViewModels.DTO.RH
{
    public class OfferBonusViewModel : GenericViewModel
    {
        public int IdOffer { get; set; }
        public int IdBonus { get; set; }
        public string DeletedToken { get; set; }
        public double? Value { get; set; }
        public DateTime ValidityStartDate { get; set; }
        public DateTime? ValidityEndDate { get; set; }

        public BonusViewModel IdBonusNavigation { get; set; }
        public OfferViewModel IdOfferNavigation { get; set; }
    }
}
