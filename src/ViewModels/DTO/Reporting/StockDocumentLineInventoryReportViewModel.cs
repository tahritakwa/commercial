using System;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class StockDocumentLineInventoryReportViewModel
    {
        //Document infos
        public DateTime? DocumentDate { get; set; }
        public string DocumentDateString { get; set; }
        public string Reference { get; set; }
        public string Designation { get; set; }
        public string WarehouseCode { get; set; }
        public string WarehouseName { get; set; }
        public string UnitHtpurchasePrice { get; set; }
        public string UnitHtsalePrice { get; set; }


        public int IdStockDocument { get; set; }
        public double? ActualQuantity { get; set; }
        public double? ForecastQuantity { get; set; }
        public int IdItem { get; set; }
        public string ArticleName { get; set; }
        public string ShelfName { get; set; }
        public string Ecart { get; set; }
        public string Ecart2 { get; set; }



    }
}
