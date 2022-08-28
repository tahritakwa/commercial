using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Payment
{
    public class OutstandingFinancialCommitmentForExportViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string CurrencyCode { get; set; }
        public int CurrencyPrecision { get; set; }
        public string CommitmentDate { get; set; }
        public string AmountWithCurrency { get; set; }
        public string AmountWithoutWithholdingTaxWithCurrency { get; set; }
        public string RemainingWithholdingTaxWithCurrency { get; set; }
        public string RemainingAmountWithCurrency { get; set; }
        public string WithholdingTaxWithCurrency { get; set; }

        public ReducedTiersViewModel IdTiersNavigation { get; set; }
        public DocumentForExportViewModel IdDocumentNavigation { get; set; }
        public OutstandingFinancialCommitmentForExportViewModel()
        {

        }
        public OutstandingFinancialCommitmentForExportViewModel(OutstandingFinancialCommitmentReducedViewModel model)
        {
            Id = model.Id;
            Code = model.Code;
            if (model.IdCurrencyNavigation != null)
            {
                CurrencyCode = model.IdCurrencyNavigation.Code;
                CurrencyPrecision = model.IdCurrencyNavigation.Precision;
            }
            if (model.IdDocumentNavigation != null)
            {
                IdDocumentNavigation = new DocumentForExportViewModel();
            }
            if (model.IdTiersNavigation != null)
            {
                IdTiersNavigation = new ReducedTiersViewModel
                {
                    Name = model.IdTiersNavigation.Name
                };
            }
        }
    }
}
