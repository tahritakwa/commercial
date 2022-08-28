using System.Collections.Generic;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Shared
{
    public class PhoneViewModel
    {
        public int Id { get; set; }
        public int? Number { get; set; }
        public string DialCode { get; set; }
        public string CountryCode { get; set; }
        public int? TransactionUserId { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }
        public int? IdContact { get; set; }
        public int? IdTier { get; set; }


        public virtual ContactViewModel IdContactNavigation { get; set; }
        public virtual TiersViewModel IdTierNavigation { get; set; }
        public virtual ICollection<BankViewModel> Bank { get; set; }


    }
}
