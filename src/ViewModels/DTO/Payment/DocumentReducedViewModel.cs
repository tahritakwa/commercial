using System;

namespace ViewModels.DTO.Payment
{
    public class DocumentReducedViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string DocumentTypeCode { get; set; }
        public int IdDocumentStatus { get; set; }
        public int? IdTiers { get; set; }
        public DateTime DocumentDate { get; set; }
    }
}
