namespace ViewModels.DTO.Sales
{
    public class InputToCalculatePriceCostViewModel
    {
        public int IdDocument { get; set; }
        public double Coefficient { get; set; }
        public double Margin { get; set; }
        public int? IdLine { get; set; }
    }
}
