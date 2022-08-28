using System;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class StockDocumentInventoryReportViewModel
    {
        //Document infos
        public string DocumentDate { get; set; }
        public string DocumentDateString { get; set; }
        public string PrintedDate { get; set; }
        public string WarehouseCode { get; set; }
        public string WarehouseName { get; set; }
        public string SupplierName { get; set; }
        public string InventoryType { get; set; }
        public string DocumentTypeCode { get; set; }
        public string DocumentTypeLabel { get; set; }
        public string DocumentCode { get; set; }
        public string WebSite { get; set; }
        public string StarkWebSiteUrl { get; set; }
        public string StarkLogo { get; set; }
        public string Rib { get; set; }
        public string BankName { get; set; }
        public ReportCompanyInformationViewModel Company { get; set; }


    }
}
