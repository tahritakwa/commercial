using System;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Sales
{
    public class BalanceDocumentLine
    {
        public string Reference { get; set; }
        public string Designation { get; set; }
        public double QtyBalance { get; set; }
        public double QtyStock { get; set; }
        public double PUPurchase { get; set; }
        public double TotalPuPurchase { get; set; }
        public double PUSales { get; set; }
        public double TotalSales { get; set; }
        public string CodeOrderDocument { get; set; }
        public DateTime DateOrderDocument { get; set; }
        public DateTime? DateDispo { get; set; }
        public int IdLine { get; set; }
        public int IdDocument { get; set; }
        public int StatusDocument { get; set; }
        public string SymboleCurrency { get; set; }
        public int PrecisionCurrency { get; set; }
        public int IdItem { get; set; }
        public NumberFormatOptionsViewModel FormatOption { get; set; }

    }
}
