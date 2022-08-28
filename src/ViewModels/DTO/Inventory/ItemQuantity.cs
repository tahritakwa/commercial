namespace ViewModels.DTO.Inventory
{
    public class ItemQuantity
    {
        public int IdItem { get; set; }
        public int? IdWarehouse { get; set; }
        public double Quantity { get; set; }
    }
}