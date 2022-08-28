namespace ViewModels.DTO.Ecommerce
{
    public class ProductMagentoViewModel
    {
        public string sku { get; set; }
        public string name { get; set; }
        public int attribute_set_id { get; set; }
        public double price { get; set; }
        public int status { get; set; }
        public int visibility { get; set; }
        public string type_id { get; set; }

        public int item_id { get; set; }
        public double weight { get; set; }
        public int qty_ordered { get; set; }
        public float price_incl_tax { get; set; }
        public string product_type { get; set; }
    }
}
