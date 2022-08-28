using System;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;

namespace ViewModels.DTO.Common
{
    [Serializable]
    public class ChatDataDetails
    {
        public MessageChatViewModel message;
        public UserDiscussionChatViewModel userSeenLastMessage;
        public int idDiscussion;
        public string newName;
        public List<UserDiscussionChatViewModel> userDiscussions;
    }
}
