using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class SettlementModeViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public ICollection<DetailsSettlementModeViewModel> DetailsSettlementMode { get; set; }
        public ICollection<DocumentViewModel> Document { get; set; }
        public ICollection<TiersViewModel> Tiers { get; set; }
    }
}
