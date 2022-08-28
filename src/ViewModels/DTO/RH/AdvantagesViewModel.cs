using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.RH
{
    public class AdvantagesViewModel : GenericViewModel
    {
        public string Description { get; set; }
        public string DeletedToken { get; set; }
        public int IdOffer { get; set; }

        public OfferViewModel IdOfferNavigation { get; set; }
    }
}
