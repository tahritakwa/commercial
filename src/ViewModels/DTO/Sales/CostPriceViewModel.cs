using System.Collections.Generic;

namespace ViewModels.DTO.Sales
{
    public class CostPriceViewModel
    {
        public int Id { get; set; }
        public string LabelItem { get; set; }
        public string Reference { get; set; }
        public int IdItem { get; set; }
        public double? PercentageMargin { get; set; }
        public double? CostPrice { get; set; }
        public double? SellingPrice { get; set; }
        public double? ItemUnitAmount { get; set; }
        public double? HtUnitAmountWithCurrency { get; set; }
        public double? VatTaxRate { get; set; }
        public double? LineHtAmount { get; set; }
        public double? Quantity { get; set; }
        public string SalePolicy { get; set; }
        public double? ConclusiveSellingPrice { get; set; }
        public string DesignationItem { get; set; }
        public string CodeItem { get; set; }
        public double? OldPrice { get; set; }
        public string Currency { get; set; }
        public double StockQty { get; set; }
        public double? OldSellingPrice { get; set; }
        public double? PudevQty { get; set; }
        public double? PrevQty { get; set; }
        public double? PvhtQty { get; set; }
        public virtual ICollection<DocumentLineTaxeViewModel> DocumentLineTaxe { get; set; }
    }
}
