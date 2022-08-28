using System.Collections.Generic;
using ViewModels.DTO.Inventory;

namespace ViewModels.Comparers
{
    public class ItemWarehouseComparatorByIdItem : IEqualityComparer<ItemWarehouseViewModel>
    {
        public bool Equals(ItemWarehouseViewModel x, ItemWarehouseViewModel y)
        {
            if (x.IdItem == y.IdItem)
            {
                return true;
            }
            return false;
        }

        public int GetHashCode(ItemWarehouseViewModel obj)
        {
            return obj.IdItem.GetHashCode();
        }
    }
}
