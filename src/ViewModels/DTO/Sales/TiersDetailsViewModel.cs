namespace ViewModels.DTO.Sales
{
    public class TiersDetailsViewModel
    {
        public double MaxThreshold { get; set; }
        public double ImpaidTotal { get; set; }
        public double Turnover { get; set; }
        public double ValidBlNotInvoiced { get; set; }
        public string currencyCode { get; set; }
        public int currencyPrecision { get; set; }
        public bool isGratherThan { get; set; }
    }
}
