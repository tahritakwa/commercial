namespace ViewModels.DTO.Provisioning
{
    public class ObjectToOrder
    {
        public int IdItem { get; set; }
        public int IdTiers { get; set; }
        public int idProvision { get; set; }
        public double MouvementQuantity { get; set; }
        public double? LastPrice { get; set; }
        public int IdCurrency { get; set; }
    }
}
