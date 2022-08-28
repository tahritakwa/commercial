using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Payment;

namespace ViewModels.DTO.Treasury
{
    public class TicketPaymentViewModel : GenericViewModel
    {
        public DateTime CreationDate { get; set; }
        public int IdTicket { get; set; }
        public int IdPaymentType { get; set; }
        public double Amount { get; set; }
        public double? ReceivedAmount { get; set; }
        public double? AmountReturned { get; set; }
        public int? Status { get; set; }
        public virtual PaymentTypeViewModel IdPaymentTypeNavigation { get; set; }
        public virtual TicketViewModel IdTicketNavigation { get; set; }
    }
}
