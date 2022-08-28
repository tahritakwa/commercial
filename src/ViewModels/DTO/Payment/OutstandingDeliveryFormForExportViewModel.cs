namespace ViewModels.DTO.Payment
{
    public class OutstandingDeliveryFormForExportViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public int IdTiers { get; set; }
        public string TiersName { get; set; }
        public string CurrencyCode { get; set; }
        public int CurrencyPrecision { get; set; }
        public string DocumentDate { get; set; }
        public string DocumentTtcpriceWithCurrency { get; set; }
        public string DocumentRemainingAmountWithCurrency { get; set; }

        public OutstandingDeliveryFormForExportViewModel()
        {

        }

        public OutstandingDeliveryFormForExportViewModel(OutstandingDeliveryFormViewModel model)
        {
            Code = model.Code;
            TiersName = model.TiersName;
            CurrencyCode = model.CurrencyCode;
            CurrencyPrecision = model.CurrencyPrecision;
        }

    }
}
