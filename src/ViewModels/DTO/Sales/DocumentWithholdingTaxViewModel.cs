using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Payment;

namespace ViewModels.DTO.Sales
{
    public class DocumentWithholdingTaxViewModel : GenericViewModel
    {
        public int IdDocument { get; set; }
        public int IdWithholdingTax { get; set; }
        public double AmountWithCurrency { get; set; }
        public double Amount { get; set; }
        public double WithholdingTaxWithCurrency { get; set; }
        public double WithholdingTax { get; set; }
        public double? RemainingWithholdingTaxWithCurrency { get; set; }
        public double? RemainingWithholdingTax { get; set; }
        public string DeletedToken { get; set; }

        public virtual DocumentViewModel IdDocumentNavigation { get; set; }
        public virtual WithholdingTaxViewModel IdWithholdingTaxNavigation { get; set; }
        public virtual ICollection<SettlementDocumentWithholdingTaxViewModel> SettlementDocumentWithholdingTax { get; set; }
    }
}
