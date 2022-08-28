using System.Collections.Generic;

namespace ViewModels.DTO.Ecommerce
{
    public class ClientViewModel
    {
        public int Id { get; set; }
        public string Nom { get; set; }
        public string Prenom { get; set; }
        public string Email { get; set; }
        public bool IsPremium { get; set; }
        public string Premium { get; set; }
        public int? IdEcommerceCustomer { get; set; }
        public List<ContactEcommerceViewModel> Contact { get; set; }
    }
}

