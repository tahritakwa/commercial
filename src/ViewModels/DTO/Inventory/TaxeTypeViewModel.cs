using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class TaxeTypeViewModel : GenericViewModel
    {
        ////BCC/ BEGIN CUSTOM CODE SECTION 
        ////ECC/ END CUSTOM CODE SECTION 
        public string TaxeTypeCode { get; set; }
        public string Description { get; set; }
        public int IdTaxeTypeCalculation { get; set; }
        public ICollection<TaxeViewModel> Taxe { get; set; }
    }
}
