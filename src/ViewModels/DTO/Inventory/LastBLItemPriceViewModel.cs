using System;

namespace ViewModels.DTO.Inventory
{
    public class LastBLItemPriceViewModel
    {
        public int idDocument { get; set; }
        public int idItem { get; set; }
        public string DocumentRef { get; set; }
        public double ItemQte { get; set; }
        public double ItemPrice { get; set; }
        public DateTime DocumentDate { get; set; }
        public double Discount { get; set; }
    }
}
