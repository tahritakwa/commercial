using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class StockDocumentLineSerialNumberViewModel : GenericViewModel
    {
        public int? IdDocumentLine { get; set; }
        public int? IdSerialNumber { get; set; }

    }
}
