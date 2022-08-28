using System;
using System.Collections.Generic;
using ViewModels.DTO.Administration;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Payment;

namespace ViewModels.DTO.Sales
{
    public class FinancialCommitmentViewModel : GenericViewModel
    {
        public FinancialCommitmentViewModel()
        {
            SettlementCommitment = new HashSet<SettlementCommitmentViewModel>();
        }
        public int? IdDocument { get; set; }
        public DateTime CommitmentDate { get; set; }
        public double AllocatedAmount { get; set; }
        public double? AllocatedAmountWithCurrency { get; set; } = 0;
        public double RemainingAmount { get; set; }
        public double? RemainingAmountWithCurrency { get; set; }
        public int? IdPaymentMethod { get; set; }
        public string DeletedToken { get; set; }
        public int? IdStatus { get; set; }
        public double? Amount { get; set; }
        public double? AmountWithCurrency { get; set; }
        public int? BenefitPeriod { get; set; }
        public int Direction { get; set; }
        public string Code { get; set; }
        public int? IdTiers { get; set; }
        public int? IdCurrency { get; set; }
        public double? ExchangeRate { get; set; }
        public DateTime? FinancialCommitmentDate { get; set; }
        public double? WithholdingTaxWithCurrency { get; set; }
        public double? WithholdingTax { get; set; }
        public double? TtcWithholdingTaxWithCurrency { get; set; }
        public double? TtcWithholdingTax { get; set; }
        public double? VatWithholdingTaxWithCurrency { get; set; }
        public double? VatWithholdingTax { get; set; }
        public double? RemainingWithholdingTax { get; set; }
        public double? RemainingWithholdingTaxWithCurrency { get; set; }
        public double? RemainingVatWithholdingTaxWithCurrency { get; set; }
        public double? RemainingVatWithholdingTax { get; set; }

        public double? AmountWithoutWithholdingTax { get; set; }
        public double? PaidWithholdingTaxWithCurrency { get; set; }
        public double? AmountWithoutWithholdingTaxWithCurrency { get; set; }
        public double HoldingTax { get; set; }
        public virtual CurrencyViewModel IdCurrencyNavigation { get; set; }
        public virtual TiersViewModel IdTiersNavigation { get; set; }
        public DocumentViewModel IdDocumentNavigation { get; set; }
        public PaymentMethodViewModel IdPaymentMethodNavigation { get; set; }
        public ICollection<SettlementCommitmentViewModel> SettlementCommitment { get; set; }
        public DocumentStatusViewModel IdStatusNavigation { get; set; }
    }
}
