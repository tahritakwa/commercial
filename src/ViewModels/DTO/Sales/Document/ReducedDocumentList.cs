using System;

namespace ViewModels.DTO.Sales.Document
{
    public class ReducedDocumentList
    {
        public int Id { get; set; }
        public string NameTiers { get; set; }
        public DateTime DocumentDate { get; set; }
        public string Code { get; set; }
        public double? DocumentHtpriceWithCurrency { get; set; }
        public double? DocumentTtcpriceWithCurrency { get; set; }
        public int? InoicingType { get; set; }
        public string DocumentStatus { get; set; }
        public string CreatorName { get; set; }
        public string Region { get; set; }
        public string PictureUrlTiers { get; set; }
        public int IdDocumentStatus { get; set; }
        public string ColorDocumentStatus { get; set; }
        public string ProvisionalCode { get; set; }
        public string DocumentTypeCode { get; set; }
        public bool? IsDeliverySuccess { get; set; }
        public bool? IsFromGarage { get; set; }
        public bool haveClaim { get; set; }
        public string CodeCurrency { get; set; }
        public int PrecisionCurrency { get; set; }
        public bool? IsBToB { get; set; }
        public bool haveReservedLines { get; set; }
        public int? IdInvoiceEcommerce  { get; set; }
        public string ValidatorName { get; set; }
        public string ItemName { get; set; }
        public int? IdCreator { get; set; }
        public bool? IsSynchronizedBToB { get; set; }
        public bool? IsForPos { get; set; }
        public int? IdSalesDepositInvoice { get; set; }
        public int? IdSessionCounterSalesState { get; set; }
        public int? IdTiers { get; set; }



    }
}
