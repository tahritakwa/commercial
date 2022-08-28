using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Payment
{
    public class SettlementDocumentWithholdingTaxViewModel : GenericViewModel
    {
        public int? IdSettlement { get; set; }
        public int? IdDocumentWithholdingTax { get; set; }
        public double? TotalAmount { get; set; }
        public double TotalAmountWithCurrency { get; set; }
        public double? AssignedWithholdingTax { get; set; }
        public double AssignedWithholdingTaxWithCurrency { get; set; }
        public string DeletedToken { get; set; }

        public virtual DocumentWithholdingTaxViewModel IdDocumentWithholdingTaxNavigation { get; set; }
        public virtual SettlementViewModel IdSettlementNavigation { get; set; }
    }
}
