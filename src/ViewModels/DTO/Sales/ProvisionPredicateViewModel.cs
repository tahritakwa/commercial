using System;
using Utils.Utilities.PredicateUtilities;

namespace ViewModels.DTO.Sales
{
    public class ProvisionPredicateViewModel
    {
        public PredicateFormatViewModel Predicate { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public int? IdTiers { get; set; }
    }
}
