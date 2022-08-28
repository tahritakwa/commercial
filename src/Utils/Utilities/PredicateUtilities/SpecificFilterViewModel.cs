namespace Utils.Utilities.PredicateUtilities
{
    public class SpecificFilterViewModel
    {
        public string Module { get; set; }
        public string Model { get; set; }
        public string PropertyOfParentEntity { get; set; }
        public virtual PredicateFormatViewModel Predicate { get; set; }

    }
}
