using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Inventory
{
    public class ShelfStorageViewModel : GenericViewModel
    {
        public string Label { get; set; }
        public int? IdShelf { get; set; }
        public bool? IsDefault { get; set; }
        public string ShelfLabel { get; set; }
        public int? IdResponsable { get; set; }
        public string OldStorageLabel { get; set; }
        public virtual UserViewModel IdResponsableNavigation { get; set; }
        public virtual ShelfViewModel IdShelfNavigation { get; set; }
        public virtual ICollection<ItemWarehouseViewModel> ItemWarehouse { get; set; }
    }
}
