using System;

namespace ViewModels.DTO.Payment
{
    public class OutstandingDeliveryFormViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public int IdTiers { get; set; }
        public string TiersName { get; set; }
        public string CurrencyCode { get; set; }
        public int CurrencyPrecision { get; set; }
        public DateTime DocumentDate { get; set; }
        public double DocumentTtcpriceWithCurrency { get; set; }
        public double DocumentRemainingAmountWithCurrency { get; set; }

    }
}
