using System.Collections.Generic;
using Utils.Enumerators;

namespace Utils.Utilities.PredicateUtilities
{
    public class PredicateFormatViewModel
    {
        public int pageSize { get; set; }
        public int page { get; set; }
        public ICollection<SpecificFilterViewModel> SpecFilter { get; set; }
        public ICollection<FilterViewModel> Filter { get; set; }
        public ICollection<OrderByViewModel> OrderBy { get; set; }
        public ICollection<RelationViewModel> Relation { get; set; }
        public ICollection<string> SpecificRelation { get; set; }
        public Operator Operator { get; set; }
        public int[] values { get; set; }
        public bool IsDefaultPredicate { get; set; }
    }
}
