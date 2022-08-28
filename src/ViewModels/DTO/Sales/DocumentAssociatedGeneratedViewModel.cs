using System;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Sales
{
    public class DocumentAssociatedGeneratedViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public int IdDocumentStatus { get; set; }
        public string DocumentTypeCode { get; set; }
        public DateTime DocumentDate { get; set; }
        public double? DocumentHtpriceWithCurrency { get; set; }
        public double? DocumentTtcpriceWithCurrency { get; set; }
        public bool? IsRestaurn { get; set; }
        public string TierRegion { get; set; }
        public string TierName { get; set; }
        public string StatusLabel { get; set; }
        public string StatusColer { get; set; }
        public NumberFormatOptionsViewModel FormatOption { get; set; }
        public bool? IsDeliverySuccess { get; set; }
       
    }
}

