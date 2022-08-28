using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Inventory
{
    public class ItemDetailsViewModel : GenericViewModel
    {

        public string Code { get; set; }
        public string Description { get; set; }
        public double? CostPrice { get; set; }
        public double AllAvailableQuantity { get; set; }
        public int IdWarehouse { get; set; }
        public string WarehouseCode { get; set; }
        public string WarehouseName { get; set; }
        public double? AvailableQuantity { get; set; }
        public int? IdUnitSales { get; set; }
        public int? IdUnitStock { get; set; }

    }
}
