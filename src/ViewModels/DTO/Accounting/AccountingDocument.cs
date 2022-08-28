using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Accounting
{
    public class AccountingDocument
    {

        public int idDocument { get; set; }
        public string codeDocument { get; set; }
        public string documentType { get; set; }
        public double amountTTC { get; set; }
        public int tierId { get; set; }
        public DateTime documentDate { get; set; }
        public string tierName { get; set; }
        public double taxStamp { get; set; }
        public bool isAccounted { get; set; }
        public List<AccountingDocumentDetail> billDetails { get; set; }
        public double ristourn { get; set; }
    }
}
