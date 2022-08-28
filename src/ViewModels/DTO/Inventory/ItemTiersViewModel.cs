using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Inventory
{
    public class ItemTiersViewModel : GenericViewModel
    {
        public int IdItem { get; set; }
        public int IdTiers { get; set; }
        public string DeletedToken { get; set; }
        public double? PurchasePrice { get; set; }
        public double? ExchangeRate { get; set; }
        public double? Margin { get; set; }
        public double? Cost { get; set; }

        public virtual ItemViewModel IdItemNavigation { get; set; }
        public virtual TiersViewModel IdTiersNavigation { get; set; }
    }
}
