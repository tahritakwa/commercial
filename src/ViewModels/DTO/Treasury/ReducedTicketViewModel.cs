
using Persistence.Entities;
using System;
using ViewModels.DTO.Administration;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Treasury
{
    public class ReducedTicketViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public DateTime CreationDate { get; set; }
        public string CashRegisterName { get; set; }
        public double Amount { get; set; }
        public string InvoiceCode { get; set; }
        public string DeliveryFormCode { get; set; }
        public int? IdInvoice { get; set; }
        public int? IdDeliveryForm { get; set; }
        public int? InvoiceStatus { get; set; }
        public int? DeliveryFormStatus { get; set; }
        public int? IdPaymentTicket { get; set; }
        public double?  InvoiceAmount { get; set; }
        public double? TicketAmount { get; set; }
        public PaymentType IdPaymentTypeNavigation { get; set; }
        public  Tiers IdTiersNavigation { get; set; }
        public ReducedCurrencyViewModel IdUsedCurrencyNavigation { get; set; }
        public TicketPaymentViewModel TicketPayment { get; set; }
    }
}
