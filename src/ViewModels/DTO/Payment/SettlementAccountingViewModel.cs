using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators.CommercialEnumerators;

namespace ViewModels.DTO.Payment
{
    public class SettlementAccounting
    {
        public int idSettlement { get; set; }
        public string codeSettlement { get; set; }
        public bool isAccounted { get; set; }
        public double paymentAmount { get; set; }
        public int tierId { get; set; }
        public string tiersName { get; set; }
        public DateTime settlementDate { get; set; }
        public int bankId { get; set; }
        public string bankName { get; set; }
        public string paymentMethodeName { get; set; }
        public string documentType { get; set; }

        public List<DocumentSettlementAccountingDetails> documentSettlementAccountingDetails { get; set; }
        public List<RistournSettlementAccountingDetails> ristournSettlementAccountingDetails { get; set; }

        public SettlementAccounting(SettlementViewModel settlementViewModel, List<SettlementDocumentWithholdingTaxViewModel> settlementDocumentWithholdingTaxs)
        {
            idSettlement = settlementViewModel.Id;
            codeSettlement = settlementViewModel.Code;
            isAccounted = settlementViewModel.IsAccounted;
            paymentAmount = Math.Round(settlementViewModel.Amount.Value, 3);
            tierId = settlementViewModel.IdTiersNavigation.Id;
            tiersName = settlementViewModel.IdTiersNavigation.Name;
            settlementDate = settlementViewModel.SettlementDate;
            bankId = settlementViewModel.IdBankAccountNavigation != null ? settlementViewModel.IdBankAccountNavigation.Id : 0;
            bankName = settlementViewModel.IdBankAccountNavigation != null ? settlementViewModel.IdBankAccountNavigation.Agency : settlementViewModel.IssuingBank;
            paymentMethodeName = settlementViewModel.IdPaymentMethodNavigation.MethodName;
            documentType = settlementViewModel.SettlementCommitment.First().Commitment.IdDocumentNavigation.DocumentTypeCode;
            documentSettlementAccountingDetails = new List<DocumentSettlementAccountingDetails>();
            ristournSettlementAccountingDetails = new List<RistournSettlementAccountingDetails>();
            foreach (SettlementCommitmentViewModel settlementCommitment in settlementViewModel.SettlementCommitment)
            {

                documentSettlementAccountingDetails.Add(new DocumentSettlementAccountingDetails
                {
                    codeDocument = settlementCommitment.Commitment.IdDocumentNavigation.Code,
                    amountSettlementDocument = settlementCommitment.AssignedAmount.Value,
                    isAsset = settlementCommitment.Commitment.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.SalesInvoiceAsset || settlementCommitment.Commitment.IdDocumentNavigation.DocumentTypeCode == DocumentEnumerator.PurchaseAsset

                });
            }
            settlementDocumentWithholdingTaxs.ForEach(settlementDocumentWithholdingTax =>
            {
                ristournSettlementAccountingDetails.Add(new RistournSettlementAccountingDetails
                {
                    idWithHoldingTax = settlementDocumentWithholdingTax.IdDocumentWithholdingTaxNavigation.IdWithholdingTax,
                    amountWithHoldingTax = settlementDocumentWithholdingTax.AssignedWithholdingTax.Value
                });

            });

        }
    }

    public class DocumentSettlementAccountingDetails
    {
        public bool isAsset { get; set; }
        public string codeDocument { get; set; }
        public double amountSettlementDocument { get; set; }
    }

    public class RistournSettlementAccountingDetails
    {

        public int idWithHoldingTax { get; set; }
        public double amountWithHoldingTax { get; set; }
    }
}
