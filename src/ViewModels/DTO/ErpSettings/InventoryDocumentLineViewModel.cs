namespace ViewModels.DTO.ErpSettings
{
    public class InventoryDocumentLineViewModel
    {
        public int Take { get; set; }
        public int Skip { get; set; }
        public int IdStockDocument { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public string Barcode1D { get; set; }
        public string Barcode2D { get; set; }
    }
}
