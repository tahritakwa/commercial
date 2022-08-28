using Persistence.Entities;
using System;
using System.Collections.Generic;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.DTO.ErpSettings;

namespace ViewModels.Builders.Specific.ErpSettings.Classes
{
    public class DiscussionChatBuilder : GenericBuilder<DiscussionViewModel, Discussion>, IDiscussionChatBuilder
    {
        private readonly IUserDiscussionChatBuilder _userDiscussionChatBuilder;
        private readonly IMessageChatBuilder _messageChatBuilder;

        public DiscussionChatBuilder(IUserDiscussionChatBuilder userDiscussionChatBuilder, IMessageChatBuilder messageChatBuilder)
        {
            _userDiscussionChatBuilder = userDiscussionChatBuilder;
            _messageChatBuilder = messageChatBuilder;
        }

        public override DiscussionViewModel BuildEntity(Discussion entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }
            DiscussionViewModel model = base.BuildEntity(entity);
            if (entity.UserDiscussionChat != null)
            {
                IList<UserDiscussionChatViewModel> userDiscussionList = new List<UserDiscussionChatViewModel>();
                foreach(UserDiscussionChat chat in  entity.UserDiscussionChat)
                {
                    userDiscussionList.Add(_userDiscussionChatBuilder.BuildEntity(chat));
                }
                model.UserDiscussionChat = userDiscussionList;
            }
            return model;
        }


    }
}
