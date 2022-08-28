using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Helpdesk
{
    public class ClaimTypeViewModel : GenericViewModel
    {
        public string CodeType { get; set; }
        public string Type { get; set; }
        public string TranslationCode { get; set; }

        public string MovementType { get; set; }
        public string Description { get; set; }
        public virtual ICollection<ClaimViewModel> Claims { get; set; }
    }
}
