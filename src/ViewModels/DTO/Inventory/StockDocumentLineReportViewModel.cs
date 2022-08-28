using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class StockDocumentLineReportViewModel : GenericViewModel
    {
        public int IdDocument { get; set; }
        public int IdStockDocument { get; set; }
        public double? ActualQuantity { get; set; }
        public double? RealActualQuantity { get; set; }
        public double? ProvisionalBLQuantity { get; set; }
        public double? ForecastQuantity { get; set; }
        public double? SoldQuantity { get; set; }
        public int IdItem { get; set; }
        public dynamic IdItemNavigation { get; set; }

        public dynamic IdStockDocumentNavigation { get; set; }
        public dynamic IdDocumentNavigation { get; set; }
    }
}
