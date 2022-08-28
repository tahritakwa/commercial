using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Common;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Shared;

namespace Services.Specific.ErpSettings.Interfaces
{
    public interface IServiceDiscussionChat : IService<DiscussionViewModel, Discussion>
    {
        DiscussionViewModel GetDiscussion(int idUser, int idReceiver);
        DiscussionViewModel GetDiscussionById(int idDiscussion, string userMail);
        DiscussionViewModel AddDiscussion(UserViewModel currentUser, UserViewModel receiverUser);
        DiscussionViewModel AddGroupDiscussion(UserViewModel currentUser, List<UserDetailChatDiscussion> listOfGroupMembers, string discussionName);
        MessageChatViewModel AddMessage(MessageChatViewModel model);
        DataSourceResult<MessageChatViewModel> GetDiscussionMessagesChat(int idDiscussion, int pageNumber, int pageSize);
        List<DiscussionViewModel> GetListDiscussionsOfCurrentUser(int id);
        MessageChatViewModel GetLastMessage(int idDiscussion);
        void NotifUserDiscussion(MessageChatViewModel message,string userMail);
        void MarkNotifUserDiscussion(UserDiscussionChatViewModel userDiscussion,string userMail);
        DiscussionViewModel AddNewMembers(ObjectToSaveViewModel objectToSave, string userMail);
        DiscussionViewModel CreateChatGroup(ObjectToSaveViewModel objectToSave, string userMail);
        DiscussionViewModel UpdateChatGroupName(ObjectToSaveViewModel objectToSave, string email);


    }
}
