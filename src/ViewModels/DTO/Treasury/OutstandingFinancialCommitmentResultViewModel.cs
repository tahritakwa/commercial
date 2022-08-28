using System.Collections.Generic;
using ViewModels.DTO.Payment;

namespace ViewModels.DTO.Treasury
{
    public class OutstandingFinancialCommitmentResultViewModel
    {
        public long Total { get; set; }
        public IList<OutstandingFinancialCommitmentReducedViewModel> Data { get; set;}
        public double? TotalAmount { get; set; }
        public double? TotalRemainingAmount { get; set; }

    }
}
