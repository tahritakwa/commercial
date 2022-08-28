using System.Collections.Generic;

namespace ViewModels.DTO.Ecommerce
{
    public class OrderMagentoViewModel
    {
        public string base_currency_code { get; set; }
        public int base_discount_amount { get; set; }
        public float base_grand_total { get; set; }
        public int base_discount_tax_compensation_amount { get; set; }
        public int base_shipping_amount { get; set; }
        public int base_shipping_discount_amount { get; set; }
        public int base_shipping_discount_tax_compensation_amnt { get; set; }
        public int base_shipping_incl_tax { get; set; }
        public int base_shipping_tax_amount { get; set; }
        public float base_subtotal { get; set; }
        public float base_subtotal_incl_tax { get; set; }
        public int base_tax_amount { get; set; }
        public float base_total_due { get; set; }
        public int base_to_global_rate { get; set; }
        public int base_to_order_rate { get; set; }
        public int billing_address_id { get; set; }
        public string created_at { get; set; }
        public string customer_email { get; set; }
        public string customer_firstname { get; set; }
        public int customer_group_id { get; set; }
        public int customer_id { get; set; }
        public int customer_is_guest { get; set; }
        public string customer_lastname { get; set; }
        public int customer_note_notify { get; set; }
        public int entity_id { get; set; }
        public ContactEcommerceViewModel billing_address { get; set; }
        public List<ProductMagentoViewModel> items { get; set; }
    }
}
