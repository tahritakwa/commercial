using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.Reporting.Treasury
{
    public class TicketLineViewModel
    {
        public double Quantity { get; set; }
        public string Designation { get; set; } 
        public string UnitSalesPrice { get; set; }
        public string TtcAmount { get; set; }
    }
}
