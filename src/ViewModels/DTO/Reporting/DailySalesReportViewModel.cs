using System;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class DailySalesReportViewModel
    {
        //Document infos
        public DateTime? DocumentDate { get; set; }
        public DateTime? PrintedDate { get; set; }
        public string WarehouseCode { get; set; }
        public string WarehouseName { get; set; }
        public string DocumentTypeCode { get; set; }
        public string DocumentTypeLabel { get; set; }
        public string DateDuAu { get; set; }
        public string StarkWebSiteUrl { get; set; }
        public string StarkLogo { get; set; }
        public string Rib { get; set; }
        public string BankName { get; set; }

        public ReportCompanyInformationViewModel Company { get; set; }
    }
}
