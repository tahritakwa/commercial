using System;
using System.Collections.Generic;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class DocumentLineReportingViewModel
    {
        // DocumentLine infos
        public double MovementQty { get; set; }
        public string Designation { get; set; } = string.Empty;
        public string Symbole { get; set; } = string.Empty;
        public double? HtUnitAmountWithCurrency { get; set; } = 0;
        public double? HtAmountWithCurrency { get; set; } = 0;
        public double? HtTotalLineWithCurrency { get; set; } = 0;
        public string MesureUnitLabel { get; set; } = string.Empty;
        public double? VatTaxRate { get; set; } = 0;
        public double? DiscountPercentage { get; set; } = 0;
        public double? UnitPriceFromQuotation { get; set; } = 0;
        public int? CurrencyPrecision { get; set; } = 0;
        public string Code { get; set; } = string.Empty;
        public string Reference { get; set; } = string.Empty;
        public string ShelfAndStorage { get; set; } = string.Empty;
        public int? IdDocumentAssociated { get; set; } = 0;
        public string IdDocumentAssociatedNavigationCode { get; set; } = string.Empty;
        public dynamic IdDocumentAssociatedNavigation { get; set; } = default;
        public double? DocumentHtpriceWithCurrency { get; set; } = 0;
        public string DocumentHtpriceWithCurrencyString { get; set; } = string.Empty;
        public string DocumentLineHeader { get; set; } = string.Empty;
        public double? VatTaxAmountWithCurrency { get; set; } = 0;
        public double? ExcVatTaxAmountWithCurrency { get; set; } = 0;
        public bool? IsNotValid { get; set; } = false;
        public string WarehouseName { get; set; } = string.Empty;
        public string CodeArticle { get; set; } = string.Empty;
        public string ShelfAndStorageOfItemCentral { get; set; } = string.Empty;

        public string DocumentTypeString { get; set; } = string.Empty;
        public string DocumentDateString { get; set; } = string.Empty;
        public string DocumentMHTString { get; set; } = string.Empty;
        public string DocumentMTTCString { get; set; } = string.Empty;
        public virtual ICollection<DocumentLineTaxeViewModel> DocumentLineTaxe { get; set; }
        public string AllVatTaxRate { get; set; } = string.Empty;
        public string HtUnitAmountWithCurrencyString { get; set; }
        public string HtTotalLineWithCurrencyString { get; set; }
        public string TTcTotalLineWithCurrencyString { get; set; }
        public double? TTcTotalLineWithCurrency { get; set; } = 0;
        public string Brand { get; set; }



    }
}
