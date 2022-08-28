using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using ViewModels.DTO.Administration;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Treasury;

namespace ViewModels.DTO.Payment
{
    public class SettlementViewModel : GenericViewModel
    {
        public SettlementViewModel()
        {
            ReflectiveSettlementIdSettlementNavigation = new HashSet<ReflectiveSettlementViewModel>();
            ReflectiveSettlementIdGapSettlementNavigation = new HashSet<ReflectiveSettlementViewModel>();
            SettlementCommitment = new HashSet<SettlementCommitmentViewModel>();
        }
        public string Code { get; set; }
        public string SettlementReference { get; set; }
        public DateTime? CommitmentDate { get; set; }
        public int IdTiers { get; set; }
        public string Label { get; set; }
        public string Holder { get; set; }
        public int Type { get; set; }
        public DateTime SettlementDate { get; set; }
        public int IdPaymentMethod { get; set; }
        public int? IdUsedCurrency { get; set; }
        public double? Amount { get; set; }
        public double AmountWithCurrency { get; set; }
        public double? ResidualAmount { get; set; }
        public double? ResidualAmountWithCurrency { get; set; }
        public double? ExchangeRate { get; set; }
        public int? IdStatus { get; set; }
        public string IssuingBank { get; set; }
        public int? IdBankAccount { get; set; }
        public int Direction { get; set; }
        public string AttachmentUrl { get; set; }
        public double? WithholdingTax { get; set; }
        public int? IdPaymentStatus { get; set; }
        public int? IdPaymentSlip { get; set; }
        public bool HasBeenReplaced { get; set; }
        public string DeletedToken { get; set; }
        public string WithholdingTaxAttachmentUrl { get; set; }
        public bool IsAccounted { get; set; }
        public bool IsReplaced { get; set; }
        public int? IdReconciliation { get; set; }
        public int? IdSessionCash { get; set; }
        public bool? IsDepositSettlement { get; set; }
        public PaymentSlipViewModel IdPaymentSlipNavigation { get; set; }
        public BankAccountViewModel IdBankAccountNavigation { get; set; }
        public PaymentMethodViewModel IdPaymentMethodNavigation { get; set; }
        public PaymentStatusViewModel IdPaymentStatusNavigation { get; set; }
        public DocumentStatusViewModel IdStatusNavigation { get; set; }
        public TiersViewModel IdTiersNavigation { get; set; }
        public CurrencyViewModel IdUsedCurrencyNavigation { get; set; }
        public ReconciliationViewModel IdReconciliationNavigation { get; set; }
        public SessionCashViewModel IdSessionCashNavigation { get; set; }
        public ICollection<ReflectiveSettlementViewModel> ReflectiveSettlementIdGapSettlementNavigation { get; set; }
        public ICollection<ReflectiveSettlementViewModel> ReflectiveSettlementIdSettlementNavigation { get; set; }
        public ICollection<SettlementCommitmentViewModel> SettlementCommitment { get; set; }
        public ICollection<SettlementDocumentWithholdingTaxViewModel> SettlementDocumentWithholdingTax { get; set; }
        public IList<IFormFile> Files { get; set; }
        public ICollection<FileInfoViewModel> FilesInfos { get; set; }
        public ICollection<string> UploadedFiles { get; set; }
        public IList<FileInfoViewModel> ObservationsFilesInfo { get; set; }
        public IList<FileInfoViewModel> WithholdingTaxObservationsFilesInfo { get; set; }

    }
}
