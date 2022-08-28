using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Inventory
{
    public class ItemPricesViewModel : GenericViewModel
    {
        public int IdItem { get; set; }
        public int IdPrices { get; set; }

        public virtual ItemViewModel IdItemNavigation { get; set; }
        public virtual PricesViewModel IdPricesNavigation { get; set; }
    }
}
