using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Helpdesk
{
    public class ClaimStatusViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }

        public string TranslationCode { get; set; }
        public virtual ICollection<ClaimViewModel> Claims { get; set; }
    }
}
