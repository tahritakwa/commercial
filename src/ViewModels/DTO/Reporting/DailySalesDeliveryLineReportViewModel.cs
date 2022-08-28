using System;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class DailySalesDeliveryLineReportViewModel
    {
        //Document infos
        public string DocumentType { get; set; }
        public DateTime? DocumentDate { get; set; }
        public string WarehouseCode { get; set; }
        public string WarehouseName { get; set; }
        public DateTime? BLDate { get; set; }
        public string BLDateString { get; set; }
        public double? BLHtAmount { get; set; }
        public double? BLTtcAmount { get; set; }
        public double? AssetTtcAmount { get; set; }

        public dynamic IdDocumentNavigation { get; set; }
        public dynamic IdTiersNavigation { get; set; }
        public int IdStockDocument { get; set; }
        public double? ActualQuantity { get; set; }
        public double? ForecastQuantity { get; set; }
        public double? SoldQuantity { get; set; }
        public string HtAmount { get; set; }
        public string TtcAmount { get; set; }
        public int? IdTiers { get; set; }

        public double? BLCount { get; set; }
        public double? AllTotalHT { get; set; }
        public double? AllTotalTTC { get; set; }
        public string ClientName { get; set; }
        public string ClientCode { get; set; }
        public int IdItem { get; set; }
        public string ArticleName { get; set; }
        public string Reference { get; set; }
        public string CodeDocument { get; set; }

    }
}
