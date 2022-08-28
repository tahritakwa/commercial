namespace ViewModels.DTO.Inventory.TecDoc
{
    public class TecDocDetailsViewModel
    {
        public int Id { get; set; }
        public string Reference { get; set; }
        public int? PackUnit { get; set; }
        public decimal? QtyPerUnit { get; set; }
        public string SupplierBrand { get; set; }
        public int SupplierId { get; set; }
        public string SupplierLogo { get; set; }
        public string ProductName { get; set; }
        public string Information { get; set; }
        public string Criteria { get; set; }
        public string OemNumbers { get; set; }
        public string EanNumbers { get; set; }
    }
}
