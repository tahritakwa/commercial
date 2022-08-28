using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Inventory
{

    public class ItemSalesPriceViewModel : GenericViewModel
    {
        public int IdSalesPrice { get; set; }
        public int IdItem { get; set; }
        public double Price { get; set; }
        public double Percentage { get; set; }
        public virtual SalesPriceViewModel IdSalesPriceNavigation { get; set; }

    }
}
