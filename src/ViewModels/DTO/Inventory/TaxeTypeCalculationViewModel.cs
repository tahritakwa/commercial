using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class TaxeTypeCalculationViewModel : GenericViewModel
    {
        public string TaxeTypeCalculationCode { get; set; }
        public string Expression { get; set; }
        public string Description { get; set; }
    }
}
