using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{

    public class TaxeItemViewModel : GenericViewModel, IEquatable<TaxeItemViewModel>
    {
        public int IdTaxe { get; set; }
        public int IdItem { get; set; }
        public virtual TaxeViewModel IdTaxeNavigation { get; set; }

        public bool Equals(TaxeItemViewModel other)
        {
            if (other == null)
                return false;

            if (IdTaxe == other.IdTaxe && IdItem == other.IdItem)
                return true;
            else
                return false;
        }
        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;

            TaxeItemViewModel taxeItem = obj as TaxeItemViewModel;
            if (taxeItem == null)
                return false;
            else
                return Equals(taxeItem);
        }
        public override int GetHashCode()
        {
            return IdTaxe.GetHashCode() ^ IdItem.GetHashCode();
        }
    }
}
