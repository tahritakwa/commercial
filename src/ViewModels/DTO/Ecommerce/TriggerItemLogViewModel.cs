using System;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;

namespace ViewModels.DTO.Ecommerce
{
    public class TriggerItemLogViewModel : GenericViewModel
    {
        public int? IdItem { get; set; }
        public string Code { get; set; }
        public string Message { get; set; }
        public DateTime? DateLog { get; set; }

        public ItemViewModel IdItemNavigation { get; set; }
    }
}
