using System;

namespace ViewModels.DTO.Ecommerce
{
    public class FailedSalesDeliveryViewModel
    {
        public string EcommerceReference { get; set; }
        public string FullName { get; set; }
        public string Telephone { get; set; }
        public string Email { get; set; }
        public DateTime CreationDate { get; set; }
        public string ErrorMessage { get; set; }

    }
}

