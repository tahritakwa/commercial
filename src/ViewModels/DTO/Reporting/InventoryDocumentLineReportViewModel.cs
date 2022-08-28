using System;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class InventoryDocumentLineReportViewModel
    {
        //Document infos
        public string DocumentType { get; set; }
        public DateTime? DocumentDate { get; set; }
        public string WarehouseCode { get; set; }
        public string WarehouseName { get; set; }
        public DateTime? BLDate { get; set; }
        public double? BLHtAmount { get; set; }
        public double? BLTtcAmount { get; set; }
        public double? AssetTtcAmount { get; set; }

        public dynamic IdDocumentNavigation { get; set; }
        public dynamic IdTiersNavigation { get; set; }
        public int IdStockDocument { get; set; }
        public double? ActualQuantity { get; set; }
        public double? ForecastQuantity { get; set; }
        public double? SoldQuantity { get; set; }
        public double? HtAmount { get; set; }
        public double? TtcAmount { get; set; }


        public double? BLCount { get; set; }
        public double? AllTotalHT { get; set; }
        public double? AllTotalTTC { get; set; }
        public string ClientName { get; set; }
        public string ClientCode { get; set; }
        public int IdItem { get; set; }
        public string ArticleName { get; set; }
        public string Reference { get; set; }
        public string Casier { get; set; }
        public string Ecart { get; set; }


    }
}
