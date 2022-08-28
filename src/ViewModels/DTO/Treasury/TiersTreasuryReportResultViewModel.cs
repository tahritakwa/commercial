using System.Collections.Generic;

namespace ViewModels.DTO.Treasury
{
    public class TiersTreasuryReportResultViewModel
    {
        public long Total { get; set; }
        public List<TiersTreasuryReport> Data { get; set; }
        public double? SumOfTotalAmount { get; set; }
        public double? SumOfTotalOverduePaymentAmount { get; set; }
        public double? SumOfTurnOver { get; set; }

    

    }
}
