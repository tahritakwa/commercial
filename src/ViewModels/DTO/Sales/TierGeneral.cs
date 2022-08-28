using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Sales
{
    public class TierGeneral
    {
        public double? LeftToPay { get; set; }
        public double? Revenue { get; set; }
        public decimal score { get; set; }
        public DocumentViewModel LastDocumentAdded { get; set; }
        public string UserFullName { get; set; }

    }
}
