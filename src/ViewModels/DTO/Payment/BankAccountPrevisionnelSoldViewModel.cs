using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Payment
{

    public class BankAccountPrevisionnelSoldViewModel : GenericViewModel
    {
        public double CurrentBalance { get; set; }
        public double CumulOfUnreconciledRegulations { get; set; }
        public double ForecastBalance { get; set; }
    }
}
