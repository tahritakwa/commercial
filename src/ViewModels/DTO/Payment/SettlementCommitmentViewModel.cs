using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Payment
{
    public class SettlementCommitmentViewModel : GenericViewModel
    {
        public int CommitmentId { get; set; }
        public int SettlementId { get; set; }
        public double? AssignedAmount { get; set; }
        public double? AssignedAmountWithCurrency { get; set; } = 0;
        public double? AssignedWithholdingTax { get; set; }
        public double? AssignedWithholdingTaxWithCurrency { get; set; }
        public virtual bool IsChecked { get; set; } = false;
        public int? Direction { get; set; }
        public string DeletedToken { get; set; }
        public double? ExchangeRate { get; set; }
        public virtual FinancialCommitmentViewModel Commitment { get; set; }
        public virtual SettlementViewModel Settlement { get; set; }
    }
}
