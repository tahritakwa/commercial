using System;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.ErpSettings
{
    public class MessageChatViewModel : GenericViewModel
    {
        public string Text { get; set; }
        public DateTime Date { get; set; }
        public string AttachedFilesLink { get; set; }
        public int IdUserDiscussion { get; set; }

        public UserDiscussionChatViewModel IdUserDiscussionNavigation { get; set; }
    }
}
