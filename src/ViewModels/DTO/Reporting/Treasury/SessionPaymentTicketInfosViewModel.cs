using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.Reporting.Treasury
{
    public class SessionPaymentTicketInfosViewModel
    {
        public string TicketCode { get; set; }
        public string CreationDate { get; set; }
        public string DeliveryFormCode { get; set; }
        public string InvoiceCode { get; set; }
        public string ClientName { get; set; }
        public string Amount { get; set; }
        public string PaymentMethod { get; set; }
    }
}
