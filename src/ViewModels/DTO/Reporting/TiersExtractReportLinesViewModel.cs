namespace ViewModels.DTO.Reporting
{
    public class TiersExtractReportLinesViewModel
    {
        public string DocumentCode { get; set; }        
        public string DocumentDate { get; set; }
        public double TotalDebit { get; set; }
        public double TotalCredit { get; set; }
        public string TotalDebitString { get; set; }
        public string TotalCreditString { get; set; }
        public int TiersType { get; set; }
        public string Balance { get; set; }
        public string Currency { get; set; }
        public int Precision { get; set; }
        public double TotalCreditWithCurrency { get; set; }
        public double TotalDebitWithCurrency { get; set; }
        public string TotalCreditStringWithCurrency { get; set; }
        public string TotalDebitStringWithCurrency { get; set; }
    }
}
