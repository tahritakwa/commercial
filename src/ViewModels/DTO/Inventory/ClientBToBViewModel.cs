using System;

namespace ViewModels.DTO.Inventory
{
    public class ClientBToBViewModel
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public byte[] Picture { get; set; }
        public int? Phone { get; set; }
        public string DialCode { get; set; }
        public string CountryCode { get; set; }

        public string WorkPhone { get; set; }
        public string MobilePhone { get; set; }
        public DateTime Birthday { get; set; }
        public string tax_group { get; set; }
        public string currency_code { get; set; }
        public string sector { get; set; }
        public string Address { get; set; }
        public DateTime? created_at { get; set; }
        public DateTime? updated_at { get; set; }
        public int IdTierStark { get; set; }
        public int? IdCategory { get; set; }

    }
}
