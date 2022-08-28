using System.Collections.Generic;

namespace ViewModels.DTO.Treasury
{
    public class FinancialCommitmentForReceivableReducedViewModel
    {
        public long Total { get; set; }
        public IList<dynamic> Data { get; set; }
        public double? TotalAmount { get; set; }
        public double? TotalRemainingAmount { get; set; }



    }
}
