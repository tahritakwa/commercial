using System.Collections.Generic;

namespace ViewModels.DTO.Sales.Document
{
    public class ImportDocumentsBSViewModel
    {
        public IList<ReducedImportLine> ReducedImportLines { get; set; }
        public int IdCurrentDocument { get; set; }
    }
}
