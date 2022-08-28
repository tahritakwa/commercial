using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.B2B
{
    public class BtoBDocumentViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Reference { get; set; }
        public int IdDocumentStatus { get; set; }
        public string DocumentTypeCode { get; set; }
        public string Informations { get; set; }
        public int? IdTiers { get; set; }
        public int? IdContact { get; set; }
        public DateTime? CreationDate { get; set; }
        public DateTime? ValidationDate { get; set; }
        public DateTime DocumentDate { get; set; }
        public DateTime? DateTerm { get; set; }
        public double? DocumentHtprice { get; set; }
        public double? DocumentTotalVatTaxes { get; set; }
        public double? DocumentTtcprice { get; set; }
        public double? DocumentRemainingAmount { get; set; }
        public double? DocumentAmountPaid { get; set; }
        public double? DocumentTotalDiscount { get; set; }
        public string AmountInLetter { get; set; }
        public bool? WithHoldingFlag { get; set; }
        public int? IdDiscountGroupTiers { get; set; }
        public int? IdPaymentMethod { get; set; }
        public int? IdTaxeGroupTiers { get; set; }
        public string MatriculeFiscale { get; set; }
        public int? IdUsedCurrency { get; set; }
        public double? ExchangeRate { get; set; }
        public double? DocumentHtpriceWithCurrency { get; set; }
        public double? DocumentTotalVatTaxesWithCurrency { get; set; }
        public double? DocumentTtcpriceWithCurrency { get; set; }
        public double? DocumentRemainingAmountWithCurrency { get; set; }
        public double? DocumentAmountPaidWithCurrency { get; set; }
        public double? DocumentTotalDiscountWithCurrency { get; set; }
        public int? IdSettlementMode { get; set; }
        public string AttachmentUrl { get; set; }
        public string DeletedToken { get; set; }
        public int? IdBankAccount { get; set; }
        public double? DocumentPriceIncludeVat { get; set; }
        public double? DocumentPriceIncludeVatwithCurrency { get; set; }
        public double? DocumentOtherTaxes { get; set; }
        public double? DocumentOtherTaxesWithCurrency { get; set; }
        public int? DocumentMonthDate { get; set; }
        public int? IdDecisionMaker { get; set; }
        public double? DocumentTotalExcVatTaxes { get; set; }
        public double? DocumentTotalExcVatTaxesWithCurrency { get; set; }
        public int? IdValidator { get; set; }
        public virtual ICollection<BtoBDocumentLineViewModel> BtobDocumentLine { get; set; }
    }
}
