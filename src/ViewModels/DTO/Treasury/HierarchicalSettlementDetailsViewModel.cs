using System.Collections.Generic;

namespace ViewModels.DTO.Treasury
{
    public class HierarchicalSettlementDetailsViewModel
    {
        public int Id { get; set; }
        public int? ParentId { get; set; }
        public Dictionary<string, string> Text { get; set; }
        public ICollection<HierarchicalSettlementDetailsViewModel> Items { get; set;}
    }
}
