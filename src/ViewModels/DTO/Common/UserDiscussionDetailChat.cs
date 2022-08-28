using System;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;

namespace ViewModels.DTO.Common
{
    [Serializable]
    public class UserDiscussionDetailChat
    {
        public UserDiscussionChatViewModel userSeenLastMessage;
        public List<UserDiscussionChatViewModel> userDiscussions;
    }
}
