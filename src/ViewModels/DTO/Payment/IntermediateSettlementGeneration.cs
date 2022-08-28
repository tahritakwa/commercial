using System;
using System.Collections.Generic;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Treasury;

namespace ViewModels.DTO.Payment
{
    public class IntermediateSettlementGeneration
    {
        public SettlementViewModel Settlement { get; set; }
        public int GapManagementMethod { get; set; }
        public string GapReason { get; set; }
        public double? GapValue { get; set; }
        public bool GetWithholdingTax { get; set; }
        public DateTime? NewFinancialCommitmentDate { get; set; }
        public List<FinancialCommitmentViewModel> SelectedFinancialCommitment { get; set; }
        public List<ReducedTicketViewModel> SelectedTicket { get; set; }
    }
}
