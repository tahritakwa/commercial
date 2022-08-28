using System;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class DailySalesDeliveryReportViewModel
    {
        //Document infos
        public DateTime? DocumentDate { get; set; }
        public DateTime? PrintedDate { get; set; }
        public string PrintedDateString { get; set; }
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
        public string Siret { get; set; }
        public string MatriculeFisc { get; set; }
        public string Tel1 { get; set; }
        public string Email { get; set; }
        public string WebSite { get; set; }
        public string StarkWebSiteUrl { get; set; }
        public string StarkLogo { get; set; }


        public double? BLCount { get; set; }
        public double? AssetCount { get; set; }
        public double? SalesAssetCount { get; set; }
        public string AllTotalHT { get; set; }
        public string AllTotalTTC { get; set; }
        public string ClientInfoName { get; set; }
        public string VatNumber { get; set; }
        public string BankName { get; set; }
        public string Rib { get; set; }

        public ReportCompanyInformationViewModel Company { get; set; }

    }
}
