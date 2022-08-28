using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Sales.Document
{
    public class DocumentWithDocumentLineViewModel
    {
        public List<DocumentLineViewModel> importedData { get; set; }
        public List<DocumentLineViewModel> gridData { get; set; }
        public int idDocument { get; set; }
        public DateTime DocumentDate { get; set; }
        public string DocumentType { get; set; }
        public int IdTiers { get; set; }
    }
}
