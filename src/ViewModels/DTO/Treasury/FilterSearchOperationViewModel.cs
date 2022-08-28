using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utils.Utilities.PredicateUtilities;

namespace ViewModels.DTO.Treasury
{
    public class FilterSearchOperationViewModel
    {
        public int IdCashRegister { get; set; }
        public int page { get; set; }
        public int pageSize { get; set; }

        public ICollection<OrderByViewModel> OrderBy { get; set; }
    }
}
