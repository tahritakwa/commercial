namespace ViewModels.DTO.Inventory
{
    public class ShelfStorageManagementViewModel
    {
        public int Id { get; set; }
        public int IdItem { get; set; }
        public int IdWarehouse { get; set; }
        public string Storage { get; set; }
        public string NewStorage { get; set; }
        public string Shelf { get; set; }
        public double AvailableQuantity { get; set; }
        public double OrderedQuantity { get; set; }
        public string Item { get; set; }
        public string WarehouseName { get; set; }

    }
}
