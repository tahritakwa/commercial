using System;

namespace ViewModels.DTO.Sales.Document
{
    [Serializable]
    public class ReducedPanierDocumentLineViewModel
    {
        public int IdItem { get; set; }
        public string CodeItem { get; set; }
        public string DesignationItem { get; set; }
        public string CodeDocument { get; set; }
        public string CodeDocumentLine { get; set; }
        public int IdDocument { get; set; }
        public double? DiscountPercentage { get; set; }
        public double? CostPrice { get; set; }
        public double? PercentageMargin { get; set; }

        public double? UnitPriceFromQuotation { get; set; }
        public double? SellingPrice { get; set; }
        public int? IdWarehouse { get; set; }
        public double MovementQty { get; set; }

        public double? HtUnitAmountWithCurrency { get; set; }
        public int? IdDocumentLineAssociated { get; set; }
        public int? IdDocumentAssociated { get; set; }
        public ReducedPanierDocumentViewModel IdDocumentAssociatedNavigation { get; set; }
        public int? IdMeasureUnit { get; set; }
        public double? HtTotalLineWithCurrency { get; set; }
        public string Designation { get; set; }
        public string CreatorFullName { get; set; }
        public int? IdUser { get; set; }
    }

    public class ReducedPanierDocumentViewModel
    {
        public string Code { get; set; }
        public DateTime DocumentDate { get; set; }
        public int Id { get; set; }
    }

}