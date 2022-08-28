using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utils.Utilities.PredicateUtilities;

namespace ViewModels.DTO.Inventory
{
    public class FilterSearchItemViewModel
    {
        public string GlobalSearchItem { get; set; }
        public int IdNature { get; set; }
        public string Oem { get; set; }
        public List<int> IdTiers { get; set; }
        public int IdProductItem { get; set; }
        public int IdFamily { get; set; }
        public int IdSubFamily { get; set; }
        public int IdVehicleBrand { get; set; }
        public string BarCodeD { get; set; }
        public double? MinUnitHtsalePrice { get; set; }
        public double? MaxUnitHtsalePrice { get; set; }
        public bool isForSale { get; set; }
        public bool isForPurchase { get; set; }
        public bool isFromSalesHistory { get; set; }
        public bool AvailableQuantity { get; set; }
        public int IdModel { get; set; }
        public int IdSubModel { get; set; }
        public int IdWarehouse { get; set; }
        public bool isExpense { get; set; }
        public bool isRestaurn { get; set; }
        public bool IsStockManaged { get; set; }
        public bool IdItemToIgnore { get; set; }
        public int IdItem { get; set; }
        public int IdStorage { get; set; }
        public bool AllAvailableQuantity { get; set; }
        public int page { get; set; }
        public int pageSize { get; set; }
        public int IdSalesPrice { get; set; }
        public bool IsProduct { get; set; }
        public int? IdCustomer { get; set; }
        public int? IdVehicle { get; set; }
        public ICollection <OrderByViewModel> OrderBy { get; set; }

    }
}
