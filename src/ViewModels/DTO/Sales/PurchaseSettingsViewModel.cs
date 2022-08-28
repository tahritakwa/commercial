using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Sales
{
    public class PurchaseSettingsViewModel : GenericViewModel
    {
        public double? PurchaseOtherTaxes { get; set; }
        public string DeletedToken { get; set; }

        public int? IdPurchasingManager { get; set; }
        public bool PurchaseAllowItemManagedInStock { get; set; }
        public bool PurchaseAllowItemRelatedToSupplier { get; set; }

        public CompanyViewModel IdNavigation { get; set; }
        public UserViewModel IdPurchasingManagerNavigation { get; set; }
    }
}
