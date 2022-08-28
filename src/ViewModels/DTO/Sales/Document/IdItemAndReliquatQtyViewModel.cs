using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Sales.Document
{
    public class IdItemAndReliquatQtyViewModel
    {
        public int IdItem { get; set; }
        public double ReliquatQty { get; set; }
        public DateTime? AvailableDate { get; set; }
    }
}
