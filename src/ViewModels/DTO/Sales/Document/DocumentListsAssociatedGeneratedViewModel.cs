using System;
using System.Collections.Generic;
using System.Text;

namespace ViewModels.DTO.Sales.Document
{
    public class DocumentListsAssociatedGeneratedViewModel
    {
        public IList<DocumentAssociatedGeneratedViewModel> AssociatedDocuments { get; set; } = new List<DocumentAssociatedGeneratedViewModel>();
        public IList<DocumentAssociatedGeneratedViewModel> GeneratedDocuments { get; set; } = new List<DocumentAssociatedGeneratedViewModel>();
        public int IdParentDocument { get; set; }
    }
}
