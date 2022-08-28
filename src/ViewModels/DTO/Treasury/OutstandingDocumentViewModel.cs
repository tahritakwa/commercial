using System;
using ViewModels.DTO.Administration;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Treasury
{
    public class OutstandingDocumentViewModel : GenericViewModel
    {
        public OutstandingDocumentViewModel()
        {
        }

        public OutstandingDocumentViewModel(int Id, DateTime CommitmentDate, int IdStatus, int OutstandingDocumentType, double DocumentRemainingAmountWithCurrency)
        {
            this.Id = Id;
            this.CommitmentDate = CommitmentDate;
            this.IdStatus = IdStatus;
            this.OutstandingDocumentType = OutstandingDocumentType;
            this.DocumentRemainingAmountWithCurrency = DocumentRemainingAmountWithCurrency;
        }
        public int? IdDocument { get; set; }
        public int OutstandingDocumentType { get; set; }
        public string Code { get; set; }
        public string Reference { get; set; }
        public int? IdTiers { get; set; }
        public DateTime? DocumentDate { get; set; }
        public DateTime CommitmentDate { get; set; }
        public int IdPaymentMethod { get; set; }
        public double? DocumentTtcprice { get; set; }
        public double? DocumentTtcpriceWithCurrency { get; set; }
        public double? DocumentRemainingAmount { get; set; }
        public double? DocumentRemainingAmountWithCurrency { get; set; }
        public int? IdCurrency { get; set; }
        public string Bank { get; set; }
        public int IdStatus { get; set; }

        public double? ExchangeRate { get; set; }
        public bool? WithholdingTaxHasBeenToken { get; set; }

        public virtual PaymentMethodViewModel IdPaymentMethodNavigation { get; set; }
        public  CurrencyViewModel IdCurrencyNavigation { get; set; }
        public TiersViewModel IdTiersNavigation { get; set; }
       

    }
}
