using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class InventoryViewModel : GenericViewModel
    {
        public int IdWarehouse { get; set; }
        public int IdItem { get; set; }
        public DateTime DocumentDate { get; set; }
    }
}
