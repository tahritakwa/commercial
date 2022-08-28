namespace ViewModels.DTO.Ecommerce
{
    public class ProductViewModel
    {
        public int IdProductStark { get; set; }
        public double? Quantity { get; set; }
        public double? Price { get; set; }
        public string State { get; set; }
        public string Message { get; set; }
        public double? PriceHTStark { get; set; }
        public string Code { get; set; }
        public int IdProd { get; set; }
        public string Design { get; set; }
        public string Function { get; set; }
        public bool IsEcommerce { get; set; }
        public int BrandId { get; set; }
        public string BrandName { get; set; }
        public string ImageUrl { get; set; }
    }
}

