using System;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class DocumentControlStatusReportViewModel
    {
        //Document infos
        public DateTime? DocumentDate { get; set; }
        public DateTime? PrintedDate { get; set; }
        public string PrintedDateString { get; set; }
        public string PrintedTime { get; set; }
        public DateTime? FromDate { get; set; }
        public string FromDateString { get; set; }
        public DateTime? ToDate { get; set; }
        public string ToDateString { get; set; }
        public string ClientName { get; set; }
        public string WarehouseCode { get; set; }
        public string WarehouseName { get; set; }
        public string DocumentTypeCode { get; set; }
        public string DocumentTypeLabel { get; set; }
        public string Adress { get; set; }
        public string ZipCode { get; set; }
        public string City { get; set; }
        public string Pays { get; set; }


        public double? DocumentCount { get; set; }
        public double? AllTotalHT { get; set; }
        public double? AllTotalTTC { get; set; }
        public string ClientInfoName { get; set; }
        public string TypeDocs { get; set; }
        public string TypeDocsTitle { get; set; }
        public string StarkLogo { get; set; }
        public string BankName { get; set; }
        public string Rib { get; set; }
        public string TotalTTCOne { get; set; }
        public string TotalTTCTwo { get; set; }
        public string TotalTTCThree { get; set; }
        public string TotalNetHTOne { get; set; }
        public string TotalNetHTTwo { get; set; }
        public string TotalNetHTThree { get; set; }
        public string CurrencyOne { get; set; }
        public string CurrencyTwo { get; set; }
        public string CurrencyThree { get; set; }

        public ReportCompanyInformationViewModel Company { get; set; }

    }
}
