using System;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Provisioning
{
    public class ProvisioningDetailsViewModel
    {
        public int Id { get; set; }
        public int IdProvisioning { get; set; }
        public int IdItem { get; set; }
        public double? MvtQty { get; set; }
        public double? LastePurchasePrice { get; set; }
        public int TransactionUserId { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }
        public int IdTiers { get; set; }

        public TiersViewModel IdTiersNavigation { get; set; }

        public ItemViewModel IdItemNavigation { get; set; }
        public ProvisioningViewModel IdProvisioningNavigation { get; set; }


        public double MinQuantity { get; set; }
        public double DeleveryDelay { get; set; }
        public double AverageSalesPerDay { get; set; }
        public double OnOrderQuantity { get; set; }
        public string CurrencyCode { get; set; }
        public int? CurrencyPrecision { get; set; }
        public double? LastSalesPrice { get; set; }
        public double? RemainingQty { get; set; }
        public string LabelVehicule { get; set; }
        public DateTime? AvailableDateReliquat { get; set; }
    }
}
