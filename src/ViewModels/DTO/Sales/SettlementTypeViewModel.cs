using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class SettlementTypeViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }

        public ICollection<DetailsSettlementModeViewModel> DetailsSettlementMode { get; set; }
    }
}
