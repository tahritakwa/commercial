namespace ViewModels.DTO.Ecommerce
{
    public class CategoryViewModel
    {
        public int id { get; set; }
        public string name { get; set; }
        public int parent_id { get; set; }
        public bool is_active { get; set; }
    }
}
