using System;
using Utils.Enumerators;

namespace Utils.Utilities.PredicateUtilities
{
    public class OrderByViewModel
    {
        public Guid IdOrderBy { get; set; }
        public string Prop { get; set; }
        public OrderByDirection Direction { get; set; }
        public virtual PredicateFormatViewModel IdPredicateFormatNavigation { get; set; }

        public OrderByViewModel()
        {

        }
        public OrderByViewModel(OrderByViewModel orderByViewModel)
        {
            IdOrderBy = orderByViewModel.IdOrderBy;
            Prop = orderByViewModel.Prop;
            Direction = orderByViewModel.Direction;
        }
    }
}
