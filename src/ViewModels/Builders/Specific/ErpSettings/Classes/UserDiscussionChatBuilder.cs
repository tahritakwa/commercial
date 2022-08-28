using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.ErpSettings;

namespace ViewModels.Builders.Specific.ErpSettings.Classes
{
    public class UserDiscussionChatBuilder : GenericBuilder<UserDiscussionChatViewModel, UserDiscussionChat>, IUserDiscussionChatBuilder
    {

        private readonly IUserBuilder _userBuilder;
        public UserDiscussionChatBuilder(IUserBuilder useruilder)
        {
            _userBuilder = useruilder;
        }
        public override UserDiscussionChat BuildModel(UserDiscussionChatViewModel entity)
        {
            UserDiscussionChat userDiscussionChat = new UserDiscussionChat();
            userDiscussionChat = base.BuildModel(entity);
            if (userDiscussionChat.IdUserNavigation != null)
            {
                userDiscussionChat.IdUserNavigation = _userBuilder.BuildModel(entity.IdUserNavigation);
            }
            return userDiscussionChat;
        }

        public override UserDiscussionChatViewModel BuildEntity(UserDiscussionChat entity)
        {
            UserDiscussionChatViewModel userDiscussionChatViewModel = new UserDiscussionChatViewModel();
            userDiscussionChatViewModel = base.BuildEntity(entity);
            if (entity.IdUserNavigation != null)
            {
                userDiscussionChatViewModel.IdUserNavigation = _userBuilder.BuildEntity(entity.IdUserNavigation);
            }
            return userDiscussionChatViewModel;
        }
    }
}
