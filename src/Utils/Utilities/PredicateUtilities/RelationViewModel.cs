using System;

namespace Utils.Utilities.PredicateUtilities
{
    public class RelationViewModel
    {
        public Guid IdRelation { get; set; }
        public string Prop { get; set; }
        public virtual PredicateFormatViewModel IdPredicateFormatNavigation { get; set; }

    }
}
