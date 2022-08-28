using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class TiersPricesViewModel : GenericViewModel
    {
        public int IdTiers { get; set; }
        public int IdPrices { get; set; }

        public virtual PricesViewModel IdPricesNavigation { get; set; }
        public virtual TiersViewModel IdTiersNavigation { get; set; }
    }
}
