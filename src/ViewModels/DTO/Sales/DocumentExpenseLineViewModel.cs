﻿using ViewModels.DTO.Administration;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;

namespace ViewModels.DTO.Sales
{
    public class DocumentExpenseLineViewModel : GenericViewModel
    {
        public string CodeExpenseLine { get; set; }
        public int IdDocument { get; set; }
        public int IdExpense { get; set; }
        public string Designation { get; set; }
        public int? IdTaxe { get; set; }
        public double HtAmoutLine { get; set; }
        public double TtcAmoutLine { get; set; }
        public string Reference { get; set; }
        public double? MNTTVA { get; set; }
        public double? MNTTTC { get; set; }
        public double HtAmountLineWithCurrency { get; set; }
        public double HtAmountLineWithCurrencyPercentage { get; set; }
        public double TtcAmountLineWithCurrency { get; set; }
        public string DeletedToken { get; set; }
        public int? IdCurrency { get; set; }
        public double? ExchangeRate { get; set; }
        public int? IdTiers { get; set; }
        public double? TaxeAmoun { get; set; }
        public double? TaxeAmount { get; set; }
        public TaxeViewModel IdTaxeNavigation { get; set; }
        public DocumentViewModel IdDocumentNavigation { get; set; }
        public virtual ExpenseViewModel IdExpenseNavigation { get; set; }
        public virtual CurrencyViewModel IdCurrencyNavigation { get; set; }
        public virtual TiersViewModel IdTiersNavigation { get; set; }
    }
}
