using System;
using ViewModels.DTO.Administration;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class DocumentLineExpenseReportingViewModel
    {
        // DocumentLine Expense infos

        public string CodeExpenseLine { get; set; }
        public int IdDocument { get; set; }
        public int IdExpense { get; set; }
        public string Designation { get; set; }
        public int? IdTaxe { get; set; }
        public double HtAmoutLine { get; set; }
        public double TtcAmoutLine { get; set; }
        public string Reference { get; set; }
        public double? MNTTVA { get; set; }
        public string MNTTVAString { get; set; }
        public double? MNTTTC { get; set; }
        public string MNTTTCString { get; set; }
        public double? MNTHT { get; set; }
        public string MNTHTString { get; set; }
        public double HtAmountLineWithCurrency { get; set; }
        public double HtAmountLineWithCurrencyPercentage { get; set; }
        public double TtcAmountLineWithCurrency { get; set; }
        public string DeletedToken { get; set; }
        public int? IdCurrency { get; set; }
        public double? ExchangeRate { get; set; }
        public int? IdTiers { get; set; }
        public double? TaxeAmoun { get; set; }
      

        public double? VatTaxAmount { get; set; } = default;
        public double? PUDEV { get; set; } = default;
        public double? PREV { get; set; } = default;
        public double? PVHT { get; set; } = default;
        public double MovementQty { get; set; }
        public string Symbole { get; set; } = string.Empty;
        public double? VatTaxRate { get; set; } = 0;
        public double? DiscountPercentage { get; set; } = 0;
        public int? CurrencyPrecision { get; set; } = 0;
        public string Code { get; set; } = string.Empty;


        public TaxeViewModel IdTaxeNavigation { get; set; }
        public DocumentViewModel IdDocumentNavigation { get; set; }
        public virtual ExpenseViewModel IdExpenseNavigation { get; set; }
        public virtual CurrencyViewModel IdCurrencyNavigation { get; set; }
        public virtual TiersViewModel IdTiersNavigation { get; set; }




    }
}
