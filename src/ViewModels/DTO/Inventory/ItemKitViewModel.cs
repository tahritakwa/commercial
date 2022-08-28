using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class ItemKitViewModel : GenericViewModel
    {
        public int IdKit { get; set; }
        public int IdItem { get; set; }
        public int? Quantity { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public ItemViewModel IdItemNavigation { get; set; }
        public ItemViewModel IdKitNavigation { get; set; }
    }
}