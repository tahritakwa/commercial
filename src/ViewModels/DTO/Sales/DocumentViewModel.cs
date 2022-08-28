using Microsoft.AspNetCore.Http;
using Persistence.Entities;
using System;
using System.Collections.Generic;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Helpdesk;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;
using ViewModels.DTO.Payment;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Sales
{

    public class DocumentViewModel : GenericViewModel
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
        public int? IdDeliveryType { get; set; }
        public string MatriculeFiscale { get; set; }
        public int? IdUsedCurrency { get; set; }
        public double? ExchangeRate { get; set; }
        public double? DocumentHtpriceWithCurrency { get; set; }
        public double? DocumentTotalVatTaxesWithCurrency { get; set; }
        public double? DocumentTtcpriceWithCurrency { get; set; }
        public double? DocumentRemainingAmountWithCurrency { get; set; }
        public double? DocumentAmountPaidWithCurrency { get; set; }
        public double? DocumentTotalDiscountWithCurrency { get; set; }
        public string DocumentVarchar2 { get; set; }
        public string DocumentVarchar3 { get; set; }
        public string DocumentVarchar7 { get; set; }
        public string DocumentVarchar8 { get; set; }
        public string Adress { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Tel1 { get; set; }
        public string Tel2 { get; set; }
        public string AttachmentUrl { get; set; }
        public int? IdBankAccount { get; set; }
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
        public virtual IList<IFormFile> Files { get; set; }
        public virtual IList<FileInfoViewModel> FilesInfos { get; set; }
        public virtual ICollection<string> UploadedFiles { get; set; }
        public virtual ICollection<DocumentLineViewModel> DocumentLine { get; set; }
        public virtual ICollection<FinancialCommitmentViewModel> FinancialCommitment { get; set; }
        public virtual ICollection<StockCalculationViewModel> StockCalculation { get; set; }
        public virtual DocumentTypeViewModel DocumentTypeCodeNavigation { get; set; }
        public virtual DocumentStatusViewModel IdDocumentStatusNavigation { get; set; }
        public virtual PaymentMethodViewModel IdPaymentMethodNavigation { get; set; }
        public virtual TiersViewModel IdTiersNavigation { get; set; }
        public BankAccountViewModel IdBankAccountNavigation { get; set; }
        public int? IdSettlementMode { get; set; }
        public SettlementModeViewModel IdSettlementModeNavigation { get; set; }
        public int DocumentMonthDate { get; set; }
        public string Consultants { get; set; }
        public bool IsChecked { get; set; }
        public ICollection<DocumentLineTaxeViewModel> DocumentLineTaxe { get; set; }
        public int? IdDocumentAssociated { get; set; }
        public bool IsTermBilling { get; set; }
        public virtual IList<CommentViewModel> Comments { get; set; }
        public ICollection<DocumentExpenseLineViewModel> DocumentExpenseLine { get; set; }
        public int? IdPriceRequest { get; set; }
        public bool IsGenerated { get; set; }
        public ContactViewModel IdContactNavigation { get; set; }
        public DeliveryTypeViewModel IdDeliveryTypeNavigation { get; set; }
        public CurrencyViewModel IdUsedCurrencyNavigation { get; set; }
        public int? IdTimeSheet { get; set; }
        public TimeSheetViewModel IdTimeSheetNavigation { get; set; }
        public int? IdProject { get; set; }

        public bool IsAccounted { get; set; }
        public bool? IsBToB { get; set; }
        public int? IdSessionCounterSales { get; set; }
        public SessionCashViewModel IdSessionCounterSalesNavigation { get; set; }
        public bool? IsForPos { get; set; }

        public bool? IsAllLinesAreAdded { get; set; }
        public bool? IsSubmited { get; set; }
        public bool? IsFromGarage { get; set; }
        public string CurrencyCode { get; set; }
        public bool? IsDeliverySuccess { get; set; }
        public bool IfLinesAreAlreadyImported { get; set; }
        public string AlreadyImportedDocumentsCodes { get; set; }
        public bool? IsSynchronizedBtoB { get; set; }
        public ProjectViewModel IdProjectNavigation { get; set; }
        public ICollection<DocumentLineViewModel> DocumentsLinesAssociated { get; set; }

        public virtual ICollection<ClaimViewModel> ClaimIdAssetDocumentNavigation { get; set; }
        public virtual ICollection<ClaimViewModel> ClaimIdDeliveryDocumentNavigation { get; set; }
        public virtual ICollection<ClaimViewModel> ClaimIdDocumentNavigation { get; set; }
        public virtual ICollection<ClaimViewModel> ClaimIdPurchaseDocumentNavigation { get; set; }
        public virtual ICollection<ClaimViewModel> ClaimIdReceiptDocumentNavigation { get; set; }
        public virtual ICollection<ClaimViewModel> ClaimIdSalesDocumentNavigation { get; set; }
        public virtual ICollection<DocumentWithholdingTaxViewModel> DocumentWithholdingTax { get; set; }
        public virtual ICollection<DocumentTaxResumeViewModel> DocumentTaxsResume { get; set; }
        public bool? isAllLinesAreAvailbles { get; set; }
        public UserViewModel IdValidatorNavigation { get; set; }

        //b2b document status
        public bool isDraft { get; set; }
        public bool isBcSent { get; set; }
        public bool isBlInProgress { get; set; }
        public bool isTotallyLivred { get; set; }
        public bool isPartiallyLivred { get; set; }
        public int? IdInvoiceEcommerce { get; set; }
        public bool? hasSalesInvoices { get; set; }
        public int? IdProvision { get; set; }
        public int? IdExchangeRate { get; set; }
        public string DeletedToken { get; set; }
        public bool isAbledToMerge { get; set; }
        public int? IdCreator { get; set; }
        public UserViewModel IdCreatorNavigation { get; set; }
        public string UserMail { get; set; }
        public bool? haveReservedLines { get; set; } = false;
        public int? InoicingType { get; set; }

        public string DocumentInvoicingNumber { get; set; }

        public DateTime? DocumentInvoicingDate { get; set; }

        public bool refused { get; set; }
        public bool IsNegotitated { get; set; }
        public double? Coefficient { get; set; }
        public bool IsContactChanged { get; set; }
        public bool? IsRestaurn { get; set; }
        public NumberFormatOptionsViewModel FormatOption { get; set; }
        public string ProvisionalCode { get; set; }

        public int? IdBillingSession { get; set; }
        public int? Priority { get; set; }
        public int? IdVehicle { get; set; }
        public int? IdSalesDepositInvoice { get; set; }
        public int? IdSalesOrder { get; set; }
        public double? DepositAmount { get; set; }
        public double? LeftToPayAmount { get; set; }
        public string DepositInvoiceCode { get; set; }
        public string InvoiceFromDepositOrderCode { get; set; }
        public string DepositOrderCode { get; set; }
        public int? IdInvoiceFromDepositOrderCode { get; set; }
        public int? InvoiceFromDepositOrderStatusCode { get; set; }
        public int? DepositOrderStatusCode { get; set; }
        public int? DepositInvoiceStatusCode { get; set; }
        public int? IdCreatorBtob { get; set; }
        public virtual VehicleViewModel IdVehicleNavigation { get; set; }
        public string AssociatedDocumentsCode { get; set; }


        /// <summary>
        /// Copy the value of current DocumentViewModel (by value without ref)
        /// </summary>
        /// <returns></returns>
        public DocumentViewModel ShallowCopy()
        {
            return (DocumentViewModel)MemberwiseClone();
        }




    }
    public class CancelOrderViewModel
    {
        public string CodeDepositInvoice { get; set; }
        public string CodeInvoice { get; set; }
        public int? IdDepositInvoiceStatus { get; set; }
        public int? IdInvoiceStatus { get; set; }
    }
}
