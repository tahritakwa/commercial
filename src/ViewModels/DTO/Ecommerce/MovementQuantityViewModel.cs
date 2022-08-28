using System.Collections.Generic;

namespace ViewModels.DTO.Ecommerce
{
    public class MovementQuantityViewModel
    {
        public string trans { get; set; }
        public List<StockQuantityViewModel> Prod { get; set; }
    }
}

