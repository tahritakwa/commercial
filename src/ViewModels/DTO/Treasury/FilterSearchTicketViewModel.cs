using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utils.Utilities.PredicateUtilities;

namespace ViewModels.DTO.Treasury
{
    public class FilterSearchTicketViewModel
        {
           
            public int IdPaymentType { get; set; }
            public int IdTiers { get; set; }
            public int IdCashRegister { get; set; }
            public int IdParentCash { get; set; }
            public DateTime? CreationDate { get; set; }
            public bool? PaidTicket { get; set; }
            public string InvoiceBLCode { get; set; }
            public string TicketCode { get; set; }
            public int page { get; set; }
            public int pageSize { get; set; }

            public ICollection<OrderByViewModel> OrderBy { get; set; }

        }
}
