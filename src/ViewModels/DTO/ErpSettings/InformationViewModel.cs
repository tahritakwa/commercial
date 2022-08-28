using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.ErpSettings
{
    public class InformationViewModel : GenericViewModel
    {
        public int IdInfo { get; set; }
        public Guid IdFunctionality { get; set; }
        public string Url { get; set; }
        public string Fr { get; set; }
        public string En { get; set; }
        public string Ar { get; set; }
        public string De { get; set; }
        public string Ch { get; set; }
        public string Es { get; set; }
        public bool? IsMail { get; set; }
        public bool? IsNotification { get; set; }
        public string MailSubject { get; set; }
        public bool? IsAcceptedInfo { get; set; }
        public bool? IsToManager { get; set; }
        public int? IdInfoParent { get; set; }
        public string TranslationKey { get; set; }
        public string Type { get; set; }
        public FunctionalityViewModel IdFunctionalityNavigation { get; set; }
        public ICollection<MessageViewModel> Message { get; set; }
        public ICollection<UserInfoViewModel> UserInfo { get; set; }
    }
}

