namespace ViewModels.DTO.Payment
{
    public class DocumentForExportViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string DocumentTypeCode { get; set; }
        public int IdDocumentStatus { get; set; }
        public int? IdTiers { get; set; }
        public string DocumentDate { get; set; }
    }
}
