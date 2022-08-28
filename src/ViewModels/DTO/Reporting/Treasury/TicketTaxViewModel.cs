using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.Reporting.Treasury
{
    public class TicketTaxViewModel
    {
        public double? TaxAmount { get; set; }
        public double? HtAmount { get; set; }
        public double? TtcAmount { get; set; }
    }
}
