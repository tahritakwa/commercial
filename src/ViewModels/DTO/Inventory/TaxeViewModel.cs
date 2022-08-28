using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Inventory
{

    public class TaxeViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public string CodeTaxe { get; set; }
        public double? TaxeValue { get; set; }
        public int TaxeType { get; set; }

        public int? IdAccountingAccountSales { get; set; }
        public int? IdAccountingAccountPurchase { get; set; }
        public ICollection<TaxeGroupTiersConfigViewModel> TaxeGroupTiersConfig { get; set; }
        public bool IsCalculable { get; set; }

    }
}
