using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class ShelfViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public int? IdWharehouse { get; set; }
        public bool? IsDefault { get; set; }
        public string OldShelfLabel { get; set; }


        public virtual WarehouseViewModel IdWharehouseNavigation { get; set; }
        public virtual ICollection<ItemWarehouseViewModel> ItemWarehouse { get; set; }
        public virtual ICollection<ShelfStorageViewModel> Storage { get; set; }
    }
}
