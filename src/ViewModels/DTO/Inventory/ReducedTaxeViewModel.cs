using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class ReducedTaxeViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string CodeTaxe { get; set; }
        public int TaxeType { get; set; }
        public double? TaxeValue { get; set; }

    }
}
