using System;
using System.Collections.Generic;
using System.Text;
using ViewModels.DTO.Reporting.Generic;

namespace ViewModels.DTO.Reporting
{
    public class PurchaseDeliveryTagViewModel
    {
        public string Date { get; set; }
        public string Warehouse { get; set; }
        public string Shelf { get; set; }
        public string Storage { get; set; }
        public string PurchaseDeliveryCode { get; set; }
        public string ItemCode { get; set; }
        public string ItemLabel { get; set; }
        public string ProductName { get; set; }
        public string BarCode { get; set; }
        public string SupplierCode { get; set; }
        public string OemCode { get; set; }
    }
}
