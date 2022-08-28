using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Sales
{
    public class ReportNegotiationDataViewModel
    {
        public List<NegotiationDetailsToPrintViewModel> negotiationDetailsToPrintViewModels { get; set; }
        public string SupplierName { get; set; }
        public DateTime DocumentDate { get; set; }
    }
}
