using System;
using System.Collections.Generic;
using System.Linq;
using ViewModels.DTO.Administration;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Helpdesk;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Sales
{

    public class ReducedDocumentViewModel : GenericViewModel
    {


        ////BCC/ BEGIN CUSTOM CODE SECTION 
        ////ECC/ END CUSTOM CODE SECTION
        public string Code { get; set; }
        public string Reference { get; set; }
        public int IdDocumentStatus { get; set; }
        public string DocumentTypeCode { get; set; }
        public string Informations { get; set; }
        public int? IdTiers { get; set; }
        public DateTime? CreationDate { get; set; }
        public DateTime? ValidationDate { get; set; }
        public DateTime DocumentDate { get; set; }
        public DateTime? DateTerm { get; set; }
        public double DocumentHtprice { get; set; }
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
        public string Name { get; set; }
        public int? IdContact { get; set; }
        public string MatriculeFiscale { get; set; }
        public int? IdUsedCurrency { get; set; }
        public double? ExchangeRate { get; set; }
        public double? DocumentHtpriceWithCurrency { get; set; }
        public double? DocumentTotalVatTaxesWithCurrency { get; set; }
        public double? DocumentTtcpriceWithCurrency { get; set; }
        public double? DocumentRemainingAmountWithCurrency { get; set; }
        public double? DocumentAmountPaidWithCurrency { get; set; }
        public double? DocumentTotalDiscountWithCurrency { get; set; }

        public double? DocumentPriceIncludeVat { get; set; }
        public double? DocumentPriceIncludeVatWithCurrency { get; set; }
        public double? DocumentOtherTaxes { get; set; }
        public double? DocumentOtherTaxesWithCurrency { get; set; }
        public bool IsSaleDocumentType { get; set; }
        public int? IdDecisionMaker { get; set; }
        public string AskedByRequest { get; set; }
        public string ApprovedByRequest { get; set; }
        public int IdDocumentAssociatedStatus { get; set; }

        public double? DocumentTotalExcVatTaxes { get; set; }
        public double? DocumentTotalExcVatTaxesWithCurrency { get; set; }
        public int? IdValidator { get; set; }
        public virtual ICollection<ReducedDocumentLineViewModel> DocumentLine { get; set; }
        public virtual ICollection<FinancialCommitmentViewModel> FinancialCommitment { get; set; }
        public virtual ICollection<StockCalculationViewModel> StockCalculation { get; set; }
        public virtual DocumentTypeViewModel DocumentTypeCodeNavigation { get; set; }
        public virtual DocumentStatusViewModel IdDocumentStatusNavigation { get; set; }
        public virtual PaymentMethodViewModel IdPaymentMethodNavigation { get; set; }
        public virtual ReducedTiersViewModel IdTiersNavigation { get; set; }
        public BankAccountViewModel IdBankAccountNavigation { get; set; }
        public int? IdSettlementMode { get; set; }
        public SettlementModeViewModel IdSettlementModeNavigation { get; set; }
        public int DocumentMonthDate { get; set; }
        public bool IsChecked { get; set; }
        public ICollection<DocumentLineTaxeViewModel> DocumentLineTaxe { get; set; }
        public int? IdDocumentAssociated { get; set; }
        public bool IsTermBilling { get; set; }
        public ICollection<DocumentExpenseLineViewModel> DocumentExpenseLine { get; set; }
        public int? IdPriceRequest { get; set; }
        public bool IsGenerated { get; set; }
        public ContactViewModel IdContactNavigation { get; set; }
        public CurrencyViewModel IdUsedCurrencyNavigation { get; set; }
        public int? IdProject { get; set; }

        public bool IsAccounted { get; set; }
        public bool? IsBToB { get; set; }
        public bool? IsAllLinesAreAdded { get; set; }
        public bool? IsSubmited { get; set; }
        public string CurrencyCode { get; set; }
        public ICollection<ReducedDocumentLineViewModel> DocumentsLinesAssociated { get; set; }

        public virtual ICollection<ClaimViewModel> ClaimIdAssetDocumentNavigation { get; set; }
        public virtual ICollection<ClaimViewModel> ClaimIdDeliveryDocumentNavigation { get; set; }
        public virtual ICollection<ClaimViewModel> ClaimIdDocumentNavigation { get; set; }
        public virtual ICollection<ClaimViewModel> ClaimIdPurchaseDocumentNavigation { get; set; }
        public virtual ICollection<ClaimViewModel> ClaimIdReceiptDocumentNavigation { get; set; }
        public virtual ICollection<ClaimViewModel> ClaimIdSalesDocumentNavigation { get; set; }




        public ReducedDocumentViewModel()
        {
        }

        public ReducedDocumentViewModel(DocumentViewModel idDocumentNavigation) : base(idDocumentNavigation)
        {
            if (idDocumentNavigation != null)
            {
                Code = idDocumentNavigation.Code;
                Reference = idDocumentNavigation.Reference;
                IdDocumentStatus = idDocumentNavigation.IdDocumentStatus;
                DocumentTypeCode = idDocumentNavigation.DocumentTypeCode;
                Informations = idDocumentNavigation.Informations;
                IdTiers = idDocumentNavigation.IdTiers;
                CreationDate = idDocumentNavigation.CreationDate;
                ValidationDate = idDocumentNavigation.ValidationDate;
                DocumentDate = idDocumentNavigation.DocumentDate;
                DateTerm = idDocumentNavigation.DateTerm;
                DocumentHtprice = idDocumentNavigation.DocumentHtprice;
                DocumentTotalVatTaxes = idDocumentNavigation.DocumentTotalVatTaxes;
                DocumentTtcprice = idDocumentNavigation.DocumentTtcprice;
                DocumentRemainingAmount = idDocumentNavigation.DocumentRemainingAmount;
                DocumentAmountPaid = idDocumentNavigation.DocumentAmountPaid;
                DocumentTotalDiscount = idDocumentNavigation.DocumentTotalDiscount;
                AmountInLetter = idDocumentNavigation.AmountInLetter;
                WithHoldingFlag = idDocumentNavigation.WithHoldingFlag;
                IdDiscountGroupTiers = idDocumentNavigation.IdDiscountGroupTiers;
                IdPaymentMethod = idDocumentNavigation.IdPaymentMethod;
                IdTaxeGroupTiers = idDocumentNavigation.IdTaxeGroupTiers;
                Name = idDocumentNavigation.Name;
                IdContact = idDocumentNavigation.IdContact;
                MatriculeFiscale = idDocumentNavigation.MatriculeFiscale;
                IdUsedCurrency = idDocumentNavigation.IdUsedCurrency;
                ExchangeRate = idDocumentNavigation.ExchangeRate;
                DocumentHtpriceWithCurrency = idDocumentNavigation.DocumentHtpriceWithCurrency;
                DocumentTotalVatTaxesWithCurrency = idDocumentNavigation.DocumentTotalVatTaxesWithCurrency;
                DocumentTtcpriceWithCurrency = idDocumentNavigation.DocumentTtcpriceWithCurrency;
                DocumentRemainingAmountWithCurrency = idDocumentNavigation.DocumentRemainingAmountWithCurrency;
                DocumentAmountPaidWithCurrency = idDocumentNavigation.DocumentAmountPaidWithCurrency;
                DocumentTotalDiscountWithCurrency = idDocumentNavigation.DocumentTotalDiscountWithCurrency;

                DocumentPriceIncludeVat = idDocumentNavigation.DocumentPriceIncludeVat;
                DocumentPriceIncludeVatWithCurrency = idDocumentNavigation.DocumentPriceIncludeVatWithCurrency;
                DocumentOtherTaxes = idDocumentNavigation.DocumentOtherTaxes;
                DocumentOtherTaxesWithCurrency = idDocumentNavigation.DocumentOtherTaxesWithCurrency;
                IsSaleDocumentType = idDocumentNavigation.IsSaleDocumentType;
                IdDecisionMaker = idDocumentNavigation.IdDecisionMaker;
                AskedByRequest = idDocumentNavigation.AskedByRequest;
                ApprovedByRequest = idDocumentNavigation.ApprovedByRequest;
                IdDocumentAssociatedStatus = idDocumentNavigation.IdDocumentAssociatedStatus;

                DocumentTotalExcVatTaxes = idDocumentNavigation.DocumentTotalExcVatTaxes;
                DocumentTotalExcVatTaxesWithCurrency = idDocumentNavigation.DocumentTotalExcVatTaxesWithCurrency;
                IdValidator = idDocumentNavigation.IdValidator;
                DocumentLine = idDocumentNavigation.DocumentLine?.Select(t => new ReducedDocumentLineViewModel(t)).ToList();
                FinancialCommitment = idDocumentNavigation.FinancialCommitment;
                StockCalculation = idDocumentNavigation.StockCalculation;
                DocumentTypeCodeNavigation = idDocumentNavigation.DocumentTypeCodeNavigation;
                IdDocumentStatusNavigation = idDocumentNavigation.IdDocumentStatusNavigation;
                IdPaymentMethodNavigation = idDocumentNavigation.IdPaymentMethodNavigation;
                IdTiersNavigation = new ReducedTiersViewModel(idDocumentNavigation.IdTiersNavigation);
                IdBankAccountNavigation = idDocumentNavigation.IdBankAccountNavigation;
                IdSettlementMode = idDocumentNavigation.IdSettlementMode;
                IdSettlementModeNavigation = idDocumentNavigation.IdSettlementModeNavigation;
                DocumentMonthDate = idDocumentNavigation.DocumentMonthDate;
                IsChecked = idDocumentNavigation.IsChecked;
                DocumentLineTaxe = idDocumentNavigation.DocumentLineTaxe;
                IdDocumentAssociated = idDocumentNavigation.IdDocumentAssociated;
                IsTermBilling = idDocumentNavigation.IsTermBilling;
                DocumentExpenseLine = idDocumentNavigation.DocumentExpenseLine;
                IdPriceRequest = idDocumentNavigation.IdPriceRequest;
                IsGenerated = idDocumentNavigation.IsGenerated;
                IdContactNavigation = idDocumentNavigation.IdContactNavigation;
                IdUsedCurrencyNavigation = idDocumentNavigation.IdUsedCurrencyNavigation;
                IdProject = idDocumentNavigation.IdProject;

                IsAccounted = idDocumentNavigation.IsAccounted;
                IsBToB = idDocumentNavigation.IsBToB;
                IsAllLinesAreAdded = idDocumentNavigation.IsAllLinesAreAdded;
                IsSubmited = idDocumentNavigation.IsSubmited;
                CurrencyCode = idDocumentNavigation.CurrencyCode;
                ClaimIdAssetDocumentNavigation = idDocumentNavigation.ClaimIdAssetDocumentNavigation;
                ClaimIdDeliveryDocumentNavigation = idDocumentNavigation.ClaimIdDeliveryDocumentNavigation;
                ClaimIdDocumentNavigation = idDocumentNavigation.ClaimIdDocumentNavigation;
                ClaimIdPurchaseDocumentNavigation = idDocumentNavigation.ClaimIdPurchaseDocumentNavigation;
                ClaimIdReceiptDocumentNavigation = idDocumentNavigation.ClaimIdReceiptDocumentNavigation;
                ClaimIdSalesDocumentNavigation = idDocumentNavigation.ClaimIdSalesDocumentNavigation;
            }
        }

        /// <summary>
        /// Copy the value of current DocumentViewModel (by value without ref)
        /// </summary>
        /// <returns></returns>
        public ReducedDocumentViewModel ShallowCopy()
        {
            return (ReducedDocumentViewModel)MemberwiseClone();
        }

    }
}
