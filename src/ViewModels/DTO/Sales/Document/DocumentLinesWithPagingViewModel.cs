using Utils.Utilities.PredicateUtilities;

namespace ViewModels.DTO.Sales.Document
{
    public class DocumentLinesWithPagingViewModel
    {
        public int IdDocument { get; set; }
        public int pageSize { get; set; }
        public int Skip { get; set; }
        public double? Coefficient { get; set; }
        public string RefDescription { get; set; }
        public bool? isSalesDocument { get; set; }
        public PredicateFormatViewModel predicate { get; set; }
    }
}
