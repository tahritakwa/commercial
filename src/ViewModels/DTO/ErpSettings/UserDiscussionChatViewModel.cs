using System.Collections.Generic;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.ErpSettings
{
    public class UserDiscussionChatViewModel
    {

        public int Id { get; set; }
        public int IdUser { get; set; }
        public int IdDiscussion { get; set; }
        public bool HasNotif { get; set; }
        public DiscussionViewModel IdDiscussionNavigation { get; set; }
        public UserViewModel IdUserNavigation { get; set; }
        public ICollection<MessageChatViewModel> MessageChat { get; set; }
    }
}
