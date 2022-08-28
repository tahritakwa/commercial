using System.Collections.Generic;

namespace ViewModels.DTO.Sales
{
    public class ImportDocumentsViewModel
    {
        public List<int> IdsDocuments { get; set; }
        public List<int> IdsDocumentLines { get; set; }
        public int IdCurrentDocument { get; set; }
        public string DocumentTypeCode { get; set; }      
        public bool? IsRestaurn { get; set; }
        public List<int> IdsDocumentWithDiscountLine { get; set; }
    }
}
