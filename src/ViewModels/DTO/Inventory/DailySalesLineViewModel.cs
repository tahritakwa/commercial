namespace ViewModels.DTO.Inventory
{

    public class DailySalesLineViewModel
    {
        public double AvailableQty { get; set; }
        public double ValidBLQty { get; set; }
        public double SoldQty { get; set; }
        public double ProvisionalBLQty { get; set; }
        public double SalesAssetQty { get; set; }
        public string Designation { get; set; }
        public string CodeItem { get; set; }
        public string WarehouseCode { get; set; }
        public string WarehouseName { get; set; }
        public string ShelfStorage { get; set; }
        public string Supplier { get; set; }
        public string Shelf { get; set; }
        public string Storage { get; set; }
    }
}
