using Utils.Utilities.PredicateUtilities;

namespace ViewModels.DTO.Inventory
{
    public class ItemFilterPeerWarehouseViewModel
    {
        public PredicateFormatViewModel predicate { get; set; }
        public FiltersItemDropdown filtersItemDropdown { get; set; }
        public bool? isB2B { get; set; }
    }
}
