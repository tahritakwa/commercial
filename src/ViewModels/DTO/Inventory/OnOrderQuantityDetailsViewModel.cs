using System;

namespace ViewModels.DTO.Inventory
{

    public class OnOrderQuantityDetailsViewModel
    {
        public string Reference { get; set; }
        public string Color { get; set; }
        public DateTime DateDoc { get; set; }
        public double Quantity { get; set; }
        public int IdDocumentStatus { get; set; }
        public string DocumentTypeCode { get; set; }
        public int IdDocument { get; set; }
        public bool IsOrderProject { get; set; }
    }
}
