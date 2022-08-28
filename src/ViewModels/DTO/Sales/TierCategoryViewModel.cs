using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class TierCategoryViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public string DeletedToken { get; set; }
        public int? IdTiers { get; set; }
        public TiersViewModel IdTiersNavigation { get; set; }
    }
}
