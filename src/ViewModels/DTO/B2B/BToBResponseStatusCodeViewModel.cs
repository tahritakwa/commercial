using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.B2B
{
    public class BToBResponseStatusCodeViewModel
    {
        public List<CanceledOrderBtobViewModel> ListOfSuccess { get; set; }

        public List<CanceledOrderBtobViewModel> ListOfError { get; set; }
    }
}
