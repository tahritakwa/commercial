using Persistence.Entities;
using System.Collections.Generic;

namespace ViewModels.DTO.Inventory
{
    public class ItemForSearche
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public IList<int> TierList { get; set; }
        public bool IsForSales { get; set; }
        public bool IsForPurchase { get; set; }
        public int IdNature { get; set; }
        public IList<int> WarehouseList { get; set; }
        public bool ExistInEcommerce { get; set; }
        public bool IsEcommerce { get; set; }
        public string BarCode2D { get; set; }
        public string BarCode1D { get; set; }
        public double? UnitHtsalePrice { get; set; }
        public bool isDecomposable { get; set; }
        public int DigitsAfterComma { get; set; }
        public string Marque { get; set; }
    }
}
