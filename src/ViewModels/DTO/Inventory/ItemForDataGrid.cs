namespace ViewModels.DTO.Inventory
{
    public class ItemForDataGrid
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public double? UnitHtsalePrice { get; set; }
        public string Marque { get; set; }

        public bool IsDecomposable { get; set; }
        public int DigitsAfterComma { get; set; }
    }
}
