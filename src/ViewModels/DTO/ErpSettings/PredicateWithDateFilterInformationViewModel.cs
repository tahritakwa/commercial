using System;
using Utils.Utilities.PredicateUtilities;

namespace ViewModels.DTO.ErpSettings
{
    public class PredicateWithDateFilterInformationViewModel
    {
        public PredicateFormatViewModel Predicate { get; set; }
        public int? Year { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public int? IdWarehouseSource { get; set; }
        public int? IdWarehouseDestination { get; set; }

        public int? Status { get; set; }
        public int? IdUser { get; set; }

    }
}
