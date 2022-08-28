using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class ReflectiveFinancialCommitmentViewModel : GenericViewModel
    {
        public int IdCommitment { get; set; }
        public int IdCommitmentReplaced { get; set; }
        public double AssignedAmount { get; set; }
        public double AssignedAmountWithCurrency { get; set; }
        public string DeletedToken { get; set; }
    }
}
