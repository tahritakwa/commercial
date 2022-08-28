using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Payment
{
    public class SettlementNotAccountedViewModel
    {
        public int? IdBankAccount { get; set; }
        public int? IdBank { get; set; }
        public int IdTiers { get; set; }
        public string TiersName { get; set; }
        public string BankName { get; set; }
        public string SettlementCode { get; set; }
        public string SettlementReference { get; set; }
        public double? PaymentAmount { get; set; }
        public double PaymentAmountWithCurrency { get; set; }
        public string PaymentMethodName { get; set; }
        public bool IsAccounted { get; set; }
        public DateTime SettlementDate { get; set; }
        public int IdSettlement { get; set; }
        public double WithholdingTax { get; set; }
        public bool IsReplaced { get; set; }

        public ICollection<SettlementCommitmentViewModel> SettlementCommitment { get; set; }
        public PaymentMethodViewModel PaymentMethodNavigation { get; set; }
        public DocumentViewModel IdDocumentNavigation { get; set; }

        public SettlementNotAccountedViewModel()
        {
        }

        public SettlementNotAccountedViewModel(SettlementViewModel settlementViewModel)
        {
            IdBankAccount = settlementViewModel.IdBankAccount;
            IdBank = settlementViewModel.IdBankAccountNavigation != null ? settlementViewModel.IdBankAccountNavigation.IdBank : 0;
            IdTiers = settlementViewModel.IdTiers;
            TiersName = settlementViewModel.IdTiersNavigation.Name;
            BankName = settlementViewModel.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer ? settlementViewModel.IssuingBank :
               settlementViewModel.IdBankAccountNavigation != null ? settlementViewModel.IdBankAccountNavigation.IdBankNavigation.Name : "";
            IsAccounted = settlementViewModel.IsAccounted;
            SettlementCode = settlementViewModel.Code;
            SettlementReference = settlementViewModel.SettlementReference;
            PaymentAmount = settlementViewModel.Amount;
            PaymentAmountWithCurrency = settlementViewModel.AmountWithCurrency;
            PaymentMethodNavigation = settlementViewModel.IdPaymentMethodNavigation;
            SettlementDate = settlementViewModel.SettlementDate;
            SettlementCommitment = settlementViewModel.SettlementCommitment;
            IdSettlement = settlementViewModel.Id;
            WithholdingTax = settlementViewModel.WithholdingTax.Value;
            IdDocumentNavigation = settlementViewModel.SettlementCommitment.FirstOrDefault().Commitment.IdDocumentNavigation;
            IsReplaced = settlementViewModel.IsReplaced;

        }
    }
}
