using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;

namespace ViewModels.DTO.Sales
{
    public class TaxeGroupTiersConfigViewModel : GenericViewModel
    {
        ////BCC/ BEGIN CUSTOM CODE SECTION 
        ////ECC/ END CUSTOM CODE SECTION 
        public int IdTaxeGroupTiers { get; set; }
        public int IdTaxe { get; set; }
        public double Value { get; set; }
        public TaxeViewModel IdTaxeNavigation { get; set; }
        public TaxeGroupTiersViewModel IdTaxeGroupTiersNavigation { get; set; }
    }
}
