using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Provisioning
{
    public class ProvisioningViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public DateTime? ProjectDate { get; set; }
        public DateTime? CreationDate { get; set; }
        public int IdProvisioningOption { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }
        public int TransactionUserId { get; set; }
        public IList<int> IdTiers { get; set; }
        public ProvisioningOptionViewModel IdProvisioningOptionNavigation { get; set; }
        public ICollection<ProvisioningDetailsViewModel> ProvisioningDetails { get; set; }
        public ICollection<TiersProvisioningViewModel> TiersProvisioning { get; set; }
        public bool? IsPurchaseOrderGenerated { get; set; }
        public string Suppliers { get; set; }
    }
}
