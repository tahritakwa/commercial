using System.Collections.Generic;

namespace ViewModels.DTO.Ecommerce
{
    public class OrderViewModel
    {
        public int IdOrderAutoshop { get; set; }
        public ClientViewModel Client { get; set; }
        public List<ProductViewModel> Product { get; set; }

    }
}

