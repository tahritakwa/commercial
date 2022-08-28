using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Payment
{
    public class OutstandinngInvoiceForExportViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public ReducedTiersViewModel IdTiersNavigation { get; set; }
        public string CurrencyCode { get; set; }
        public int CurrencyPrecision { get; set; }
        public string DocumentDate { get; set; }
        public string DocumentTtcpriceWithCurrency { get; set; }
        public string DocumentRemainingAmountWithCurrency { get; set; }
        public string IdDocumentStatus { get; set; }
        public int NumberOfInvoice { get; set; }
        public OutstandinngInvoiceForExportViewModel()
        {

        }
        public OutstandinngInvoiceForExportViewModel(OutstandinngInvoiceViewModel model)
        {
            Id = model.Id;
            Code = model.Code;
            if (model.IdTiersNavigation != null)
            {
                IdTiersNavigation = new ReducedTiersViewModel
                {
                    Name = model.IdTiersNavigation.Name
                };
            }
            if (model.IdCurrencyNavigation != null)
            {
                CurrencyCode = model.IdCurrencyNavigation.Code;
                CurrencyPrecision = model.IdCurrencyNavigation.Precision;
            }

        }

    }
}
