namespace ViewModels.DTO.Sales.Document
{
    public class ItemForGarageToGenerateDocumentViewModel
    {
        public int IdItem { get; set; }
        public int? IdDocument { get; set; }
        public int? IdDocumentLine { get; set; }
        public int? IdTiers { get; set; }
        public bool? IsFromGarage { get; set; }
        public int? IdUsedCurrency { get; set; }
        public int? IdDocumentStatus { get; set; }
        public string DocumentTypeCode { get; set; }
        public double QuantityForDocumentLine { get; set; }
        public int? IdWarehouse { get; set; }
        public bool IsValidReservationFromProvisionalStock { get; set; }
        public bool IsRestaurn { get; set; }
        public bool IsDeleted { get; set; }
    }
}
