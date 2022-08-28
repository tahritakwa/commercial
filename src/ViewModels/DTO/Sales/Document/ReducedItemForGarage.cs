namespace ViewModels.DTO.Sales.Document
{
    public class ReducedItemForGarage
    {
        public int IdItem { get; set; }
        public int IdTaxe { get; set; }
        public int ? IdWarehouse { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public double Htprice { get; set; }
        public double Ttcprice { get; set; } 
        public double Quantity { get; set; }
    }
}
