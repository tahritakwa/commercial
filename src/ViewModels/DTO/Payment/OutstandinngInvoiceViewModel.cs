using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Payment
{
    public class OutstandinngInvoiceViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public int IdTiers { get; set; }
        public ReducedTiersViewModel IdTiersNavigation { get; set; }
        public OutstandingCurrencyReducedViewModel IdCurrencyNavigation { get; set; }
        public DateTime DocumentDate { get; set; }
        public string DocumentTypeCode { get; set; }
        public double DocumentTtcpriceWithCurrency { get; set; }
        public double DocumentRemainingAmountWithCurrency { get; set; }
        public int IdDocumentStatus { get; set; }
        public ICollection<OutstandingFinancialCommitmentReducedViewModel> FinancialCommitment { get; set; }
        public OutstandinngInvoiceViewModel()
        {

        }
        public OutstandinngInvoiceViewModel(Document document)
        {
            Id = document.Id;
            Code = document.Code;
            IdTiers = (int)document.IdTiers;
            DocumentTypeCode = document.DocumentTypeCode;
            if (document.IdTiersNavigation != null)
            {
                IdTiersNavigation = new ReducedTiersViewModel
                {
                    Id = document.IdTiersNavigation.Id,
                    Name = document.IdTiersNavigation.Name,
                    CodeTiers = document.IdTiersNavigation.CodeTiers,
                    IdCurrency = document.IdTiersNavigation.IdCurrency
                };
            }
            if (document.IdUsedCurrencyNavigation != null)
            {
                IdCurrencyNavigation = new OutstandingCurrencyReducedViewModel()
                {
                    Code = document.IdUsedCurrencyNavigation.Code,
                    Precision = document.IdUsedCurrencyNavigation.Precision
                };
            }
            DocumentDate = document.DocumentDate;
            DocumentTtcpriceWithCurrency = document.DocumentTtcpriceWithCurrency.Value;
            DocumentRemainingAmountWithCurrency = document.DocumentRemainingAmountWithCurrency.Value;
            IdDocumentStatus = document.IdDocumentStatus;
            FinancialCommitment = document.FinancialCommitment.Select(x => new OutstandingFinancialCommitmentReducedViewModel(x)).ToList();
        }

    }
}
