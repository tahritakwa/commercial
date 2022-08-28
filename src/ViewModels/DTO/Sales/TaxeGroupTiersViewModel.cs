using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class TaxeGroupTiersViewModel : GenericViewModel
    {
        ////BCC/ BEGIN CUSTOM CODE SECTION 
        ////ECC/ END CUSTOM CODE SECTION 
        public string Code { get; set; }
        public string Label { get; set; }
        public ICollection<TaxeGroupTiersConfigViewModel> TaxeGroupTiersConfig { get; set; }
    }
}
