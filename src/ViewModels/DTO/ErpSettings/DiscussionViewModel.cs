using System;
using System.Collections.Generic;

namespace ViewModels.DTO.ErpSettings
{
    public class DiscussionViewModel
    {

        public int Id { get; set; }
        public string Name { get; set; }
        public int NumberOfDiscussionMember { get; set; }
        public MessageChatViewModel LastMsg { get; set; }
        public bool HasNotif { get; set; }
        public DateTime DateLastNotif { get; set; }

        public virtual ICollection<UserDiscussionChatViewModel> UserDiscussionChat { get; set; }
    }
}
