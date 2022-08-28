using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Provisioning
{
    public class ProvisioningOptionViewModel
    {
        public int Id { get; set; }
        public bool SearchByQty { get; set; }
        public bool SearchByPurhaseHistory { get; set; }
        public bool SearchBySalesHistory { get; set; }
        public DateTime? PucrahseStartDate { get; set; }
        public DateTime? PucrahseEndDate { get; set; }
        public DateTime? SalesStartDate { get; set; }
        public DateTime? SalesEndDate { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }
        public int TransactionUserId { get; set; }
        public bool SearchByNewReferences { get; set; }
        public DateTime? NewReferencesStartDate { get; set; }
        public DateTime? NewReferencesEndDate { get; set; }


        public virtual ICollection<ProvisioningViewModel> Provisioning { get; set; }
    }
}
