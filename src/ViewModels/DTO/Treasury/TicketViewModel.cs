using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Treasury
{
    public class TicketViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public DateTime CreationDate { get; set; }
        public int Status { get; set; }
        public int IdDeliveryForm { get; set; }
        public int IdSessionCash { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public int? IdInvoice { get; set; }

        public DocumentViewModel IdDeliveryFormNavigation { get; set; }
        public SessionCashViewModel IdSessionCashNavigation { get; set; }
        public DocumentViewModel IdInvoiceNavigation { get; set; }
        public ICollection<TicketPaymentViewModel> TicketPayment { get; set; }
        public ICollection<string> SettlementCode { get; set; }

        public string EntityName { get; set; } = "";
        // Used for import Excel
        public string CreationDateTime { get; set; }
        public string PaymentType { get; set; }
    }
}
