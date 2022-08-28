using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Shared
{
    public class ContactTypeDocumentViewModel : GenericViewModel
    {
        public int? IdContact { get; set; }
        public string CodeTypeDocument { get; set; }
        public bool? IsChecked { get; set; }

        public DocumentTypeViewModel CodeTypeDocumentNavigation { get; set; }
        public ContactViewModel IdContactNavigation { get; set; }
    }
}
