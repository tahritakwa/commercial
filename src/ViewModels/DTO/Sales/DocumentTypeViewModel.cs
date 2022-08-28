using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class DocumentTypeViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public string Description { get; set; }
        public string DefaultCodeDocumentTypeAssociated { get; set; }
        public bool IsStockAffected { get; set; }
        public bool CreateAssociatedDocument { get; set; }
        public bool IsSaleDocumentType { get; set; }
        public bool IsFinancialCommitmentAffected { get; set; }
        public int? FinancialCommitmentDirection { get; set; }
        public bool IsActiveGeneration { get; set; }
        public string LabelEn { get; set; }
        public virtual ICollection<DocumentViewModel> Document { get; set; }

    }
}
