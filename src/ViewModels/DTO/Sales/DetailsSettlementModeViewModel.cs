using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Payment;

namespace ViewModels.DTO.Sales
{
    public class DetailsSettlementModeViewModel : GenericViewModel
    {
        public int? IdSettlementMode { get; set; }
        public int? IdSettlementType { get; set; }
        public int? IdPaymentMethod { get; set; }
        public double? Percentage { get; set; }
        public int? NumberDays { get; set; }
        public int? SettlementDay { get; set; }
        public string LabelSettlementType { get; set; }
        public string MethodNamePaymentMethod { get; set; }
        public string CompletePrinting { get; set; }

        public SettlementModeViewModel IdSettlementModeNavigation { get; set; }
        public SettlementTypeViewModel IdSettlementTypeNavigation { get; set; }
        public PaymentMethodViewModel IdPaymentMethodNavigation { get; set; }
    }
}
