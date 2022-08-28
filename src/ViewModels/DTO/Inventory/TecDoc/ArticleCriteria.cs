namespace ViewModels.DTO.Inventory.TecDoc
{
    public class ArticleCriteria
    {
        public int criteriaId { get; set; }
        public string criteriaDescription { get; set; }
        public string criteriaAbbrDescription { get; set; }
        public string criteriaType { get; set; }
        public string rawValue { get; set; }
        public string formattedValue { get; set; }
        public bool immediateDisplay { get; set; }
        public bool isMandatory { get; set; }
        public bool isInterval { get; set; }
        public string criteriaUnitDescription { get; set; }
    }
}
