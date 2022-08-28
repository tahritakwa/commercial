using Persistence.Entities;
using System;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Payment
{
    public class OutstandingFinancialCommitmentReducedViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public int? IdTiers { get; set; }
        public int? IdCurrency { get; set; }
        public OutstandingCurrencyReducedViewModel IdCurrencyNavigation { get; set; }
        public int? IdDocument { get; set; }
        public int? IdStatus { get; set; }
        public DateTime CommitmentDate { get; set; }
        public double? AmountWithCurrency { get; set; }
        public double? AmountWithoutWithholdingTaxWithCurrency { get; set; }
        public double? RemainingAmountWithCurrency { get; set; }
        public double? WithholdingTaxWithCurrency { get; set; }
        public double? RemainingWithholdingTaxWithCurrency { get; set; }
        public double? VatWithholdingTaxWithCurrency { get; set; }
        public double? RemainingVatWithholdingTaxWithCurrency { get; set; }

        public ReducedTiersViewModel IdTiersNavigation { get; set; }
        public DocumentReducedViewModel IdDocumentNavigation { get; set; }
        public OutstandingFinancialCommitmentReducedViewModel()
        {

        }
        public OutstandingFinancialCommitmentReducedViewModel(FinancialCommitment financialCommitment)
        {
            Id = financialCommitment.Id;
            Code = financialCommitment.Code;
            IdTiers = financialCommitment.IdTiers;
            IdCurrency = financialCommitment.IdCurrency;
            IdDocument = financialCommitment.IdDocument;
            IdStatus = financialCommitment.IdStatus;
            CommitmentDate = financialCommitment.CommitmentDate;
            AmountWithCurrency = financialCommitment.AmountWithCurrency;
            AmountWithoutWithholdingTaxWithCurrency = financialCommitment.AmountWithoutWithholdingTaxWithCurrency;
            RemainingAmountWithCurrency = financialCommitment.RemainingAmountWithCurrency;
            WithholdingTaxWithCurrency = financialCommitment.WithholdingTaxWithCurrency;
            RemainingWithholdingTaxWithCurrency = financialCommitment.RemainingWithholdingTaxWithCurrency;
            WithholdingTaxWithCurrency = financialCommitment.WithholdingTaxWithCurrency;
            if (financialCommitment.IdCurrencyNavigation != null)
            {
                IdCurrencyNavigation = new OutstandingCurrencyReducedViewModel()
                {
                    Code = financialCommitment.IdCurrencyNavigation.Code,
                    Precision = financialCommitment.IdCurrencyNavigation.Precision
                };
            }
            if (financialCommitment.IdDocumentNavigation != null)
            {
                IdDocumentNavigation = new DocumentReducedViewModel()
                {
                    Id = financialCommitment.IdDocumentNavigation.Id,
                    Code = financialCommitment.IdDocumentNavigation.Code,
                    DocumentTypeCode = financialCommitment.IdDocumentNavigation.DocumentTypeCode,
                    IdDocumentStatus = financialCommitment.IdDocumentNavigation.IdDocumentStatus,
                    IdTiers = financialCommitment.IdDocumentNavigation.IdTiers,
                    DocumentDate = financialCommitment.IdDocumentNavigation.DocumentDate
                };
            }
            if (financialCommitment.IdTiersNavigation != null)
            {
                IdTiersNavigation = new ReducedTiersViewModel
                {
                    Id = financialCommitment.IdTiersNavigation.Id,
                    Name = financialCommitment.IdTiersNavigation.Name,
                    CodeTiers = financialCommitment.IdTiersNavigation.CodeTiers,
                    IdCurrency = financialCommitment.IdTiersNavigation.IdCurrency
                };
            }
        }
    }
}
