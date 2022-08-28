using System;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class InventoryDocumentReportViewModel
    {
        //Document infos
        public DateTime? DocumentDate { get; set; }
        public DateTime? PrintedDate { get; set; }
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }
        public string ClientName { get; set; }
        public string WarehouseCode { get; set; }
        public string WarehouseName { get; set; }
        public string DocumentTypeCode { get; set; }
        public string DocumentTypeLabel { get; set; }
        public string Name { get; set; }
        public string Adress { get; set; }
        public string ZipCode { get; set; }
        public string City { get; set; }
        public string Pays { get; set; }
        public string CommercialRegister { get; set; }
        public string MatriculeFisc { get; set; }
        public string Tel1 { get; set; }
        public string Email { get; set; }
        public string Etat { get; set; }


        public double? DocumentCount { get; set; }
        public double? AllTotalHT { get; set; }
        public double? AllTotalTTC { get; set; }
        public string ClientInfoName { get; set; }
        public string TypeDocs { get; set; }
        public string TypeDocsTitle { get; set; }

    }
}
