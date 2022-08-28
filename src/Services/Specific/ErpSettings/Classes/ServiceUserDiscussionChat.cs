using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.ErpSettings.Classes
{

    public class ServiceUserDiscussionChat : Service<UserDiscussionChatViewModel, UserDiscussionChat>, IServiceUserDiscussionChat
    {
        public ServiceUserDiscussionChat(IRepository<UserDiscussionChat> entityRepo,
            IUnitOfWork unitOfWork,
            IUserDiscussionChatBuilder entityBuilder,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IEntityAxisValuesBuilder builderEntityAxisValues)
             : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
        }

        public void AddUserDiscussion(int idDiscussion, int idUser, int idReceiver)
        {
            UserDiscussionChatViewModel userDiscussionCurrentUser = new UserDiscussionChatViewModel
            {
                IdUser = idUser,
                IdDiscussion = idDiscussion

            };
            AddModel(userDiscussionCurrentUser, null, null);
            UserDiscussionChatViewModel userDiscussionReceiverUser = new UserDiscussionChatViewModel
            {
                IdUser = idReceiver,
                IdDiscussion = idDiscussion

            };
            AddModel(userDiscussionReceiverUser, null, null);

        }
        public void AddUserDiscussion(int idDiscussion, int idUser)
        {
            UserDiscussionChatViewModel userDiscussionCurrentUser = new UserDiscussionChatViewModel
            {
                IdUser = idUser,
                IdDiscussion = idDiscussion

            };
            AddModel(userDiscussionCurrentUser, null, null);

        }
        
    }
}
