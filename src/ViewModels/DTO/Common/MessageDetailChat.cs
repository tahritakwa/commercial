using System;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;

namespace ViewModels.DTO.Common
{
    [Serializable]
    public class MessageDetailChat
    {
        public MessageChatViewModel message;
        public List<UserDiscussionChatViewModel> userDiscussions;

    }
}
