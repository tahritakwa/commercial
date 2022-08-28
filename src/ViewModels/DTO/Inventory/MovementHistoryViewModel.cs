using System;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Inventory
{
    public class MovementHistoryViewModel
    {
        public int Id { get; set; }
        public string SupplierCode { get; set; }
        public int? IdItem { get; set; }
        public string ItemCode { get; set; }
        public string ItemDesignation { get; set; }
        public string DocumentType { get; set; }
        public string CustomerCode { get; set; }
        public string CustomerName { get; set; }
        public DateTime? Date { get; set; }
        public string OrderNumber { get; set; }
        public double? Quantity { get; set; }
        public double? Puht { get; set; }
        public double? Puht1 { get; set; }
        public double? Price { get; set; }
        public double? Discount { get; set; }
        public bool IsPurchase { get; set; }
        public bool IsSale { get; set; }
        public string FiscalYear { get; set; }
        public int pageSize { get; set; }
        public int page { get; set; }
        public ItemViewModel IdItemNavigation { get; set; }
        public NumberFormatOptionsViewModel FormatOption { get; set; }
        public string CurrencyCode { get; set; }
    }
}
