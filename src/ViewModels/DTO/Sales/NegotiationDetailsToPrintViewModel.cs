using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Sales
{
    public class NegotiationDetailsToPrintViewModel
    {
        public string Reference { get; set; }
        public string Designation { get; set; }
        //prix untaire d'achat
        public double HtPurchasePrice { get; set; }
        //prix demander 
        public double RequestedPrice { get; set; }
        //quantité demander 
        public double RequestedQuantity { get; set; }
         
    }
}
