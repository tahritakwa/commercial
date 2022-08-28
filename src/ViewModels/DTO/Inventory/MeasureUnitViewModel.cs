using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class MeasureUnitViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string MeasureUnitCode { get; set; }
        public string Description { get; set; }
        public bool IsDecomposable { get; set; }
        public int DigitsAfterComma { get; set; }
    }
}
