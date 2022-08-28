using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Provisioning
{
    public class TiersProvisioningViewModel
    {
        public int Id { get; set; }
        public int IdTiers { get; set; }
        public int IdProvisioning { get; set; }
        public double? Total { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public string DeletedToken { get; set; }

        public ProvisioningViewModel IdProvisioningNavigation { get; set; }
        public TiersViewModel IdTiersNavigation { get; set; }


        public string CurrencyCode { get; set; }
        public int CurrencyPrecision { get; set; }
    }
}
