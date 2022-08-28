using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Helpdesk
{
    public class ClaimInteractionViewModel : GenericViewModel
    {
        public int IdClaim { get; set; }
        public DateTime? DocumentDate { get; set; }
        public string TypeInteraction { get; set; }
        public string Description { get; set; }
        public string TranslationCode { get; set; }
        public string DeletedToken { get; set; }

        public virtual ClaimViewModel IdClaimNavigation { get; set; }
    }
}
