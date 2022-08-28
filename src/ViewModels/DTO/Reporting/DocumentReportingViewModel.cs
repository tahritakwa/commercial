using System;
using System.Collections.Generic;
using ViewModels.DTO.Administration;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class DocumentReportingViewModel
    {
        // Document infos
        public string DocumentTypeCode { get; set; } = string.Empty;
        public DateTime? DocumentDate { get; set; } = default;
        public DateTime? DocumentInvoicingDate { get; set; } = default;
        public string Code { get; set; } = string.Empty;
        public TiersViewModel IdTiersNavigation { get; set; }
        public ContactViewModel IdContactNavigation { get; set; }
        public string DocumentVarchar2 { get; set; } = string.Empty;
        public string DocumentVarchar3 { get; set; } = string.Empty;
        public string DocumentVarchar7 { get; set; } = string.Empty;
        public string DocumentVarchar8 { get; set; } = string.Empty;
        public double DocumentHtpriceWithCurrency { get; set; } = 0;
        public double DocumentTotalVatTaxesWithCurrency { get; set; } = 0;
        public double DocumentTtcpriceWithCurrency { get; set; } = 0;
        public string AmountInLetter { get; set; } = string.Empty;
        public BankAccountViewModel IdBankAccountNavigation { get; set; }
        public SettlementModeViewModel IdSettlementModeNavigation { get; set; }
        public CurrencyViewModel IdUsedCurrencyNavigation { get; set; }
        public string LabelTypeTiers { get; set; }
        public double DocumentTotalDiscountWithCurrency { get; set; } = 0;
        public string DocumentSymboleCurrency { get; set; }
        public int DocumentCurrencyPresicion { get; set; } = 0;
        public double DocumentOtherTaxesWithCurrency { get; set; } = 0;
        public double DocumentPriceIncludeVatWithCurrency { get; set; } = 0;
        public double DocumentTotalExcVatTaxesWithCurrency { get; set; } = 0;
        public string DocumentTotalInString { get; set; } = string.Empty;
        public string TelTiers { get; set; } = "";
        public string MFTiers { get; set; } = "";
        public string NameTiers { get; set; } = "";
        public string Reference { get; set; } = "";

        public double DocumentTotalBrut { get; set; } = 0;
        public ICollection<DocumentLineReportingViewModel> DocumentLine { get; set; }
        public VehicleViewModel IdVehicleNavigation { get; set; }

    }
}
