using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class StockCalculationViewModel : GenericViewModel
    {
        public int IdDocument { get; set; }
        public int IdMovementSheet { get; set; }
    }
}
