namespace ViewModels.DTO.Inventory
{
    public class AmountPerItemDetails
    {
        public int IdItem { get; set; }
        public string Description { get; set; }
        public string Code { get; set; }
        public double AvailableQuantity { get; set; }
        public double Quantity { get; set; }
        public double AmountWithCurrency { get; set; }
        public double TotalAmountWithCurrency { get; set; }
        public string CurrencySymbole { get; set; }
        public int PrecisionCurrency { get; set; }
        public string MesureUnitDescription { get; set; }
        public int MesureUnitPrescion { get; set; }
    }
}