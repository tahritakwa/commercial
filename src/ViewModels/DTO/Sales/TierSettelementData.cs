using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Sales
{

    public class TierSettlementData
    {
        public List<TierSettelementMode> tierIdList { get; set; }
        public DateTime date { get; set; }
        public DateTime invoicingDate { get; set; }
        public bool isBl { get; set; }
    }
}
