using System.Collections.Generic;

namespace ViewModels.DTO.Payment
{
    public class SettlementHistoryDataResultViewModel
    {
        public IList<SettlementViewModel> Settlements { get; set; }
        public double TotalAmountOfSettlements { get; set; }
        public int Total { get; set; }
    }
}
