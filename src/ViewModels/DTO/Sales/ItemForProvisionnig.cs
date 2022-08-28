namespace ViewModels.DTO.Sales
{
    public class ItemForProvisionnig
    {
        public double? LastPrice;

        public string ItemCode { get; set; }
        public string ItemDescription { get; set; }
        public int IdItem { get; set; }
        public int IdTiers { get; set; }
        public string TiersName { get; set; }
        public double AvailableQuantity { get; set; }
        public double MinQuantity { get; set; }
        public double DeleveryDelay { get; set; }
        public double AverageSalesPerDay { get; set; }
        public double MouvementQuantity { get; set; }
        public double OnOrderQuantity { get; set; }
        public int? IdCurrency { get; set; }
        public string CurrencyCode { get; set; }
        public int CurrencyPrecision { get; set; }
    }
}
