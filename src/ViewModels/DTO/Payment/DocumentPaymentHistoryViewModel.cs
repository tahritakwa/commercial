using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Payment
{
    public class DocumentPaymentHistoryViewModel : GenericViewModel
    {
        public SettlementViewModel Settlement { get; set; }
        public double? AssignedAmount { get; set; }
        public double? AssignedAmountWithCurrency { get; set; }
        public double? AssignedWithholdingTax { get; set; }
        public double? AssignedWithholdingTaxWithCurrency { get; set; }
        public List<SettlementCommitmentViewModel> SettlementCommitmentsAssociatedToSettlement { get; set; }

    }
}
