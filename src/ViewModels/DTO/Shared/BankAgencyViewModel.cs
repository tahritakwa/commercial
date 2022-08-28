using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{
    public class BankAgencyViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public int? IdBank { get; set; }

        public virtual BankViewModel IdBankNavigation { get; set; }
        public virtual ICollection<ContactViewModel> Contact { get; set; }
    }
}
