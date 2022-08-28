namespace ViewModels.DTO.Sales.Document
{
    public class DocumentTotalPricesViewModel
    {
        public double DocumentHtpriceWithCurrency { get; set; }
        public double DocumentTotalVatTaxesWithCurrency { get; set; }
        public double DocumentTtcpriceWithCurrency { get; set; }
        public double DocumentTotalDiscountWithCurrency { get; set; }
        public double DocumentPriceIncludeVatWithCurrency { get; set; }
        public double DocumentOtherTaxesWithCurrency { get; set; }
        public double DocumentTotalExcVatTaxesWithCurrency { get; set; }

    }
}
