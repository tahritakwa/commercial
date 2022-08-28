using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Payment
{

    public class SettlementForReconciliationResultViewModel : GenericViewModel
    {
        public List<ReducedSettlementViewModel> Data { get; set; }
        public List<int> AllSettlementIds { get; set; }
        public long Total { get; set; }
        public double TotalAmount { get; set; }
    }
}
