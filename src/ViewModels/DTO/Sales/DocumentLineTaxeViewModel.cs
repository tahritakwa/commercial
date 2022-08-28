using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;

namespace ViewModels.DTO.Sales
{

    public class DocumentLineTaxeViewModel : GenericViewModel
    {
        public int IdTaxe { get; set; }
        public int IdDocumentLine { get; set; }
        public double? TaxeValue { get; set; }
        public double? TaxeBase { get; set; }
        public double? TaxeAmount { get; set; }
        public double? TaxeBaseWithCurrency { get; set; }
        public double? TaxeValueWithCurrency { get; set; }
        public string TaxeName { get; set; }
        public virtual DocumentLineViewModel IdDocumentLineNavigation { get; set; }
        public virtual TaxeViewModel IdTaxeNavigation { get; set; }
        public int TaxType { get; set; }
        public string DeletedToken { get; set; }
    }
}
