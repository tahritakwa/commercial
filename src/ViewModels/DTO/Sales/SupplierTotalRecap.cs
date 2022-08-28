namespace ViewModels.DTO.Sales
{
    public class SupplierTotalRecap
    {
        public int IdTiers { get; set; }
        public double? TotalPrices { get; set; }
        public string TiersName { get; set; }
        public string CurrencyCode { get; set; }
        public int CurrencyPrecision { get; set; }

    }
}
