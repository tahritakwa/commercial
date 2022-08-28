using System.Collections.Generic;

namespace ViewModels.DTO.Payment
{
    public class SettlemenToAddInPaymentSlipResultViewModel
    {
        public List<ReducedSettlementViewModel> Data { get; set; }
        public List<int> AllSettlementIds { get; set; }
        public long Total { get; set; }
        public double TotalAmount { get; set; }
    }
}