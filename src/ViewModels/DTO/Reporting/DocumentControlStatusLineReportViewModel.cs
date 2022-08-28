using System;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class DocumentControlStatusLineReportViewModel
    {
        //Document infos
        public string DocumentType { get; set; }
        public string DocumentStatus { get; set; }
        public string DocumentCode { get; set; }
        public DateTime? DocumentDate { get; set; }
        public string DocumentDateString { get; set; }
        public string Symbole { get; set; }

        public DateTime? BLDate { get; set; }
        public double? BLHtAmount { get; set; }
        public double? BLTtcAmount { get; set; }
        public string BLTtcAmountString { get; set; }
        public double? BLNetHTAmount { get; set; }
        public string BLNetHTAmountString { get; set; }

        public dynamic IdDocumentNavigation { get; set; }
        public dynamic IdTiersNavigation { get; set; }
        public dynamic IdTiers { get; set; }
        public double? HtAmount { get; set; }
        public double? TtcAmount { get; set; }

        public string ClientName { get; set; }
        public string ClientCode { get; set; }
        public string IdCurrency { get; set; }

    }
}
