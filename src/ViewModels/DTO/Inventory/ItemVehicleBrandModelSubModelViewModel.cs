using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class ItemVehicleBrandModelSubModelViewModel : GenericViewModel
    {
        public int? IdItem { get; set; }
        public int? IdVehicleBrand { get; set; }
        public int? IdModel { get; set; }
        public int? IdSubModel { get; set; }

        public ItemViewModel IdItemNavigation { get; set; }
        public ModelOfItemViewModel IdModelNavigation { get; set; }
        public SubModelViewModel IdSubModelNavigation { get; set; }
        public VehicleBrandViewModel IdVehicleBrandNavigation { get; set; }

    }
}