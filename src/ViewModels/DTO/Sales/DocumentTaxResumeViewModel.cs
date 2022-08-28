using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;

namespace ViewModels.DTO.Sales
{
    public class DocumentTaxResumeViewModel : GenericViewModel
    {
        public int? IdTax { get; set; }
        public double? HtAmount { get; set; }
        public double? HtAmountWithCurrency { get; set; }
        public double? TaxAmount { get; set; }
        public double? TaxAmountWithCurrency { get; set; }
        public string DeletedToken { get; set; }
        public int IdDocument { get; set; }
        public double? DiscountAmount { get; set; }
        public double? DiscountAmountWithCurrency { get; set; }
        public double? ExcVatTaxAmount { get; set; }
        public double? ExcVatTaxAmountWithCurrency { get; set; }

        public virtual DocumentViewModel IdDocumentNavigation { get; set; }
        public virtual TaxeViewModel IdTaxNavigation { get; set; }
    }
}
