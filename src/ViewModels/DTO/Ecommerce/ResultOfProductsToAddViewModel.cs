using System.Collections.Generic;

namespace ViewModels.DTO.Ecommerce
{
    public class ResultOfProductsToAddViewModel
    {
        public List<int> ExistInPsProductToIsEcommerce { get; set; }
        public List<int> ExistInPsProductToNotIsEcommerce { get; set; }
        public List<int> ExistInProductToAdd { get; set; }
        public List<ProductViewModel> Add { get; set; }
    }
}

