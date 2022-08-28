using System;

namespace ViewModels.DTO.Accounting
{
    public class ImportedAccountingDocument
    {
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int AccountingStatus { get; set; }
        public string DocumentType { get; set; }
        public int Skip { get; set; }
        public int Take { get; set; }
        public FiltreDocument FiltreDocument { get; set; }
    }

    public class FiltreDocument
    {
        public string DocumentCode { get; set; }
        public string TierName { get; set; }
        public double? AmountTTC { get; set; }
        public DateTime? DocumentDate { get; set; }
    }
}
