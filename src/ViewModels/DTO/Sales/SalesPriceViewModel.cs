using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class SalesPriceViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public double Value { get; set; }
        public bool IsActivated  { get; set; }
    }
}
