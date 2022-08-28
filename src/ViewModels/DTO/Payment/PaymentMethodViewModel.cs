using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Payment
{

    public class PaymentMethodViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string MethodName { get; set; }
        public string Description { get; set; }
        public bool AuthorizedForExpenses { get; set; }
        public bool AuthorizedForRecipes { get; set; }
        public bool Immediate { get; set; }
        public int? IdPaymentType { get; set; }
        public PaymentTypeViewModel IdPaymentTypeNavigation { get; set; }
        public virtual PaymentTypeViewModel PaymentType { get; set; }
    }
}
