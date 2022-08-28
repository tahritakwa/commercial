using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Sales.Document
{
    public class ReducedDocumentForGarage
    {
        public int Id { get; set; }
        public int IdTiers { get; set; }
        public string DocumentTypeCode { get; set; }
        public int IdDocumentStatus { get; set; }
        public DateTime? DocumentDate { get; set; }
        public DateTime? ValidationDate { get; set; }
        public IList<ReducedDocumentLineForGarage> ReducedDocumentLineForGarage { get; set; }
    }
}
