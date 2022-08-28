using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class LocationViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string LocationCode { get; set; }
        public string Description { get; set; }
    }
}
