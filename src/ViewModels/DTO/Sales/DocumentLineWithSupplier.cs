namespace ViewModels.DTO.Sales
{
    public class DocumentLineWithSupplier
    {
        public int IdCurrency { get; set; }
        public int IdDocumentAssocieted { get; set; }
        public int IdTiers { get; set; }
        public DocumentLineViewModel DocumentLine { get; set; }
        public int IdPriceRequest { get; set; }
    }
}
