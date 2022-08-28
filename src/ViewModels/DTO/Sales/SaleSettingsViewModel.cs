using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Sales
{
    public class SaleSettingsViewModel : GenericViewModel
    {
        public double? SaleOtherTaxes { get; set; }
        public string DeletedToken { get; set; }
        public int? InvoicingDay { get; set; }
        public bool InvoicingEndMonth { get; set; }
        public CompanyViewModel IdNavigation { get; set; }
        public bool SaleAllowItemManagedInStock { get; set; }
        public bool AllowEditionItemDesignation { get; set; }
    }
}
