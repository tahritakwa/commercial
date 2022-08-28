using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Inventory
{

    public class StockDocumentLineViewModel : GenericViewModel
    {
        public int IdDocument { get; set; }
        public int IdStockDocument { get; set; }
        public double? ActualQuantity { get; set; }
        public double? RealActualQuantity { get; set; }
        public double? ProvisionalBLQuantity { get; set; }
        public double? ForecastQuantity { get; set; }
        public double? SoldQuantity { get; set; }
        public int IdItem { get; set; }
        public double? AvailableQuantity { get; set; }
        public int? IdWarehouse { get; set; }
        public int? IdUnitStock { get; set; }
        public string Shelf { get; set; }
        public string Storage { get; set; }
        public double? ForecastQuantity2 { get; set; }
        public ItemViewModel IdItemNavigation { get; set; }
        public virtual WarehouseViewModel IdWarehouseNavigation { get; set; }
        public StockDocumentViewModel IdStockDocumentNavigation { get; set; }
        public DocumentViewModel IdDocumentNavigation { get; set; }
    }
}
