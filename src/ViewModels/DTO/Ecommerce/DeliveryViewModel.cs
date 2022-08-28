using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;

namespace ViewModels.DTO.Ecommerce
{
    public class DeliveryViewModel : GenericViewModel
    {
        public int IdItem { get; set; }

        public ItemViewModel IdItemNavigation { get; set; }

    }
}

