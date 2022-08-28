using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModels.DTO.B2B
{
   public class EquivalenceItemForBtoBViewModel
    {
        public Guid? EquivalenceItem { get; set; }
        public int? IdItem { get; set; }
        public List<int>  EquivalenceItems { get; set; }
    }
}
