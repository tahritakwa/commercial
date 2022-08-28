using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.ErpSettings.Interfaces
{
    public interface  IServiceUserDiscussionChat : IService<UserDiscussionChatViewModel, UserDiscussionChat>
    {
        void AddUserDiscussion(int idDiscussion, int idUser, int idReceiver);
        void AddUserDiscussion(int idDiscussion, int idUser);
    }
}
