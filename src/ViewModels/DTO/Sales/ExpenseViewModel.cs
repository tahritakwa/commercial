using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;

namespace ViewModels.DTO.Sales
{
    public class ExpenseViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Description { get; set; }
        public int IdItem { get; set; }
        public int? IdSupplier { get; set; }
        public virtual ICollection<ItemTiersViewModel> ItemTiers { get; set; }
        public string DeletedToken { get; set; }
        public int IdTaxe { get; set; }
        public ItemViewModel IdItemNavigation { get; set; }
        public ICollection<DocumentExpenseLineViewModel> ExpenseLine { get; set; }
        public virtual TaxeViewModel IdTaxeNavigation { get; set; }
        public ICollection<TiersViewModel> ListTiers { get; set; }
        public ICollection<string> NamesTiers { get; set; }
        public string TiersNamesString { get; set; }
    }
}
