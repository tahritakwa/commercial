using Utils.Utilities.PredicateUtilities;

namespace ViewModels.DTO.ErpSettings
{
    public class InventoryDocumentViewModel
    {
        public int Take { get; set; }
        public int Skip { get; set; }
        public int IdStockDocument { get; set; }
        public string RefDescription { get; set; }
        public PredicateFormatViewModel Predicate { get; set; }
    }
}
