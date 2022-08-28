using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Payment
{
    public class PaymentStatusViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string DeletedToken { get; set; }

        public virtual ICollection<SettlementViewModel> Settlement { get; set; }
    }
}
