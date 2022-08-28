using System.Collections.Generic;

namespace ViewModels.DTO.Ecommerce
{
    public class ResponseSynchronizedProductViewModel
    {
        public string keyvalue { get; set; }
        public List<SuccessResponseViewModel> ListOfSuccess { get; set; }
        public List<ErrorResponseViewModel> ListOfError { get; set; }
    }
}
