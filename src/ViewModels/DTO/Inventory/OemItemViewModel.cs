using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class OemItemViewModel : GenericViewModel
    {
        public int IdItem { get; set; }
        public int? IdBrand { get; set; }
        public string OemNumber { get; set; }
        public string DeletedToken { get; set; }
        public string OemNumberModified { get; set; }
        public virtual VehicleBrandViewModel IdBrandNavigation { get; set; }
        public virtual ItemViewModel IdItemNavigation { get; set; }
    }
}
