using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Reporting.Treasury
{
    public class TicketPosReportViewModel
    {

        public string TicketCode { get; set; }
        public string SellerName { get; set; }
        public string CreationDate { get; set; }
        public string CashCode { get; set; }
        public string TtcAmount { get; set; }
        public int? TotalTicketLine { get; set; }
        public string UsedCurrency { get; set; }

        public List<TicketTaxViewModel> TicketTaxResumes { get; set; }
        public List<TicketPaymentMethodViewModel> PaymentMethod { get; set; }
        public List<TicketLineViewModel> TicketLines { get; set; }
        public ReportCompanyInformationViewModel Company { get; set; }
    }
}
