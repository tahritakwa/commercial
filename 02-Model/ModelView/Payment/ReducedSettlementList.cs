using Microsoft.AspNetCore.Http;
using ModelView.Administration;
using ModelView.Models;
using SparkIt.ModelView.Payment;
using SparkIt.ModelView.Sales;
using SparkIt.ModelView.Shared;
using System;
using System.Collections.Generic;
using System.Text;

namespace ModelView.Payment
{
    public class ReducedSettlementList
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public double AmountWithCurrency { get; set; }
        public DateTime? CommitmentDate { get; set; }
        public bool HasBeenReplaced { get; set; }
        public string Holder { get; set; }
        public int? IdBankAccount { get; set; }
        public string Rib { get; set; }
        public string Agency { get; set; }
        public string BankName { get; set; }
        public string MethodName { get; set; }
        public int? IdPaymentStatus { get; set; }
        public int IdTiers { get; set; }
        public string TiersName { get; set; }
        public int IdTypeTiers { get; set; }
        public int? IdPaymentSlip { get; set; }
        public int? IdReconciliation { get; set; }
        public int Precision { get; set; }
        public string CurrencyCode { get; set; }
        public string IssuingBank { get; set; }
        public string Label { get; set; }
        public string PaymentMethodCode { get; set; }
        public ICollection<SettlementCommitmentViewModel> SettlementCommitment { get; set; }
        public DateTime SettlementDate { get; set; }
        public ICollection<SettlementDocumentWithholdingTaxViewModel> SettlementDocumentWithholdingTax { get; set; }
        public string SettlementReference { get; set; }
        public ICollection<FileInfoViewModel> FilesInfos { get; set; }
        public IList<FileInfoViewModel> ObservationsFilesInfo { get; set; }
        public IList<FileInfoViewModel> WithholdingTaxObservationsFilesInfo { get; set; }
        public double? WithholdingTax { get; set; }
        public string WithholdingTaxAttachmentUrl { get; set; }
        public bool Immediate { get; set; }
        public string AttachmentUrl { get; set; }

    }
}
