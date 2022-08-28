using System;
using System.Collections.Generic;

namespace ViewModels.DTO.Sales
{
    public class DocumentLineWithPriceRequestViewModel
    {
        public IList<DocumentLineViewModel> documentLines { get; set; }
        public int IdTier { get; set; }
        public DateTime DocumentDate { get; set; }
        public string DocumnetType { get; set; }
        public int IdDocumentAssociated { get; set; }
    }
}
