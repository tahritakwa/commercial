using System;

namespace ViewModels.DTO.Sales.Document
{
    public class DocumentMovementDetail
    {
        public string Code { get; set; }
        public string Reference { get; set; }
        public DateTime? DocumentDate { get; set; }
        public int? IdTiers { get; set; }
        public int IdDocument { get; set; }
        public string TiersCode { get; set; }
        public string TiersName { get; set; }
        public string DocumentTypeCode { get; set; }
        public double Quantity { get; set; }
        public double PurchaseQuantity { get; set; }
        public double SalesQuantity { get; set; }
        public double PurchaseAmount { get; set; }
        public double SalesAmount { get; set; }
        public int Status { get; set; }
        public bool IsSalesDocument { get; set; }
        public bool IsInventoryDocument { get; set; }
        public bool IsReservedLine { get; set; }
        public int StatusLine { get; set; }
    }
}
