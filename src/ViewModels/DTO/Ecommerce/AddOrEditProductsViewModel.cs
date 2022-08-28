using System.Collections.Generic;

namespace ViewModels.DTO.Ecommerce
{
    public class AddOrEditProductsViewModel
    {
        public List<ProductViewModel> AddProducts { get; set; }
        public EditProductsViewModel EditProducts { get; set; }
    }
}

