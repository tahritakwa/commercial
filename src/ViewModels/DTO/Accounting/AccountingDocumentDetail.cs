namespace ViewModels.DTO.Accounting
{
    public class AccountingDocumentDetail
    {
        public double pretaxAmount { get; set; }
        public int idTax { get; set; }
        public double vatAmount { get; set; }
        public string vatName { get; set; }
        public int vatType { get; set; }
    }
}