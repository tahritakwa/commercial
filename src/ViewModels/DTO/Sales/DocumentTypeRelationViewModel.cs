using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Sales
{
    public class DocumentTypeRelationViewModel : GenericViewModel
    {
        public string CodeDocumentType { get; set; }
        public string CodeDocumentTypeAssociated { get; set; }

        public virtual DocumentTypeRelationViewModel CodeDocumentTypeNavigation { get; set; }
        public virtual DocumentTypeRelationViewModel CodeDocumentTypeAssociatedNavigation { get; set; }
    }
}
