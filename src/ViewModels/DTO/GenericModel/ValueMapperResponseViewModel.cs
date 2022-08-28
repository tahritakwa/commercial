using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Inventory;

namespace ViewModels.DTO.GenericModel
{
    public class ValueMapperResponseViewModel
    {
        public ValueMapperViewModel ValueMapper { get; set; }
        public PredicateFormatViewModel Predicate { get; set; }
        public FiltersItemDropdown filtersItemDropdown { get; set; }
    }
}
