namespace ViewModels.DTO.Sales.Document
{
    public class DocumentLineUnitPriceViewModel
    {
        public int IdCurrency { get; set; }
        public string DocumentTypeCode { get; set; }
        public double HtUnitAmount { get; set; }
        public double? DiscountPercentage { get; set; }
        public double HtAmount { get; set; }
    }
}
