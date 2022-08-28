using Utils.Enumerators.CommercialEnumerators;

namespace ViewModels.DTO.Inventory
{
    public class ItemWarehouseListItemViewModel
    {
        public int IdItem { get; set; }
        public string WarehouseName { get; set; }
        public double CMD { get; set; }
        public string CRP { get; set; }
        public string Shelf { get; set; }
        public string Storage { get; set; }
        public double? MinQuantity { get; set; }
        public double AvailableQuantity { get; set; }
        public double TradedQuantity { get; set; }
        public double ToOrderQuantity { get; set; }
        public double ReservedQuantityInDelivery { get; set; }
        public double OutTransferedQuantity { get; set; }
        public double InTransferedQuantity { get; set; }
        public double SumOnOrderedReservedQuantity { get; set; }
        public bool IsCentralWarehouse { get; set; }
        public WarehouseState State { get; set; }
    }
}
