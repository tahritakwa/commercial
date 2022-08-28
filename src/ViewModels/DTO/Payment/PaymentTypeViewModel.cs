using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Payment
{

    public class PaymentTypeViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string DeletedToken { get; set; }
        public string Code { get; set; }
        public ICollection<PaymentMethodViewModel> PaymentMethods { get; set; }
    }
}
