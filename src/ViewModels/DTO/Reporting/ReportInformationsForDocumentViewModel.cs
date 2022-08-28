using System;
using System.Collections.Generic;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class ReportInformationsForDocumentViewModel
    {
        public DocumentReportingViewModel Document { get; set; }
        public IList<GroupedTaxLineViewModel> GroupedDocumentLine { get; set; }
        public ReportCompanyInformationViewModel Company { get; set; }
        public string Rib { get; set; }
        public string BankName { get; set; }
        public string CompanyTel { get; set; }

        public string DocumentTypeLabel { get; set; }
        public string ContractCode { get; set; }
        public string PrintType { get; set; } = string.Empty;
        public string IsAsset { get; set; } = string.Empty;
        public string AdressTiers { get; set; } = string.Empty;
        public bool? IsNotValid { get; set; } = false;
        public string VatRate { get; set; }
        public double? GroupedDocumentLineCount { get; set; }
        public string DateOfDoc { get; set; } = string.Empty;
        public string InvoicingDate { get; set; } = string.Empty;
        public string IdCreator { get; set; } = string.Empty;
        public string MontantDevise { get; set; }
        public double? CoursDeChange { get; set; }
        public string MontantDinars { get; set; }
        public string MontantCharge { get; set; }
        public double? MargeDepense { get; set; }
        public double? TotalTTC { get; set; }
        public double? CoefAchat { get; set; }
        public double? CoefVente { get; set; }
        public double? TotalHT { get; set; }
        public string NoteFacture { get; set; }
        public string NumeroFacture { get; set; }
        public string CurrencyLabel { get; set; }
        public string DocumentTotalDiscountWithCurrency { get; set; }
        public string DocumentHtpriceWithCurrency { get; set; }
        public string DocumentTotalVatTaxesWithCurrency { get; set; }
        public string DocumentOtherTaxesWithCurrency { get; set; }
        public string DocumentTtcpriceWithCurrency { get; set; }
        public string DocumentPriceIncludeVatWithCurrency { get; set; }
        public string DocumentTotalExcVatTaxesWithCurrency { get; set; }
        public string DocumentTotalBrut { get; set; }
        public string StarkWebSiteUrl { get; set; }
        public string StarkLogo { get; set; }
        public string Reference { get; set; }
        public string AmountInLetter { get; set; }
        public string BaseVat1 { get; set; }
        public string BaseVat2 { get; set; }
        public string BaseVat3 { get; set; }
        public string AmountVat1 { get; set; }
        public string AmountVat2 { get; set; }
        public string AmountVat3 { get; set; }
        public string TauxVat1 { get; set; }
        public string TauxVat2 { get; set; }
        public string TauxVat3 { get; set; }
        public bool? IsDepositInvoice { get; set; }
        public bool? IsProvisonalDepositInvoice { get; set; }
        public string DepositAmount { get; set; }
        public string DepositInvoiceNumber { get; set; }
        public string RemainingAmount { get; set; }
        public string TelTiers { get; set; } = string.Empty;
        public string DateTimeOfdoc { get; set; } = string.Empty;
        public GroupedTaxLineViewModel GroupedDocumentLine1 { get; set; }
        public GroupedTaxLineViewModel GroupedDocumentLine2 { get; set; }
        public VehicleViewModel IdVehicleNavigation { get; set; }
    }
}
