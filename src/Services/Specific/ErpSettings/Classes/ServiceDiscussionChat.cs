using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils.Constants;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.DTO.Common;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Utils;

namespace Services.Specific.ErpSettings.Classes
{

    public class ServiceDiscussionChat : Service<DiscussionViewModel, Discussion>, IServiceDiscussionChat
    {
        public readonly IServiceMessageChat _serviceMessageChat;
        public readonly IServiceUserDiscussionChat _serviceUserDiscussionChat;
        public readonly IServiceUser _serviceUser;

        public ServiceDiscussionChat(IRepository<Discussion> entityRepo, IUnitOfWork unitOfWork,
           IDiscussionChatBuilder entityBuilder,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IEntityAxisValuesBuilder builderEntityAxisValues,
            IServiceMessageChat serviceMessageChat, IServiceUser serviceUser,
             IServiceUserDiscussionChat serviceUserDiscussionChat)
             : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceMessageChat = serviceMessageChat;
            _serviceUserDiscussionChat = serviceUserDiscussionChat;
            _serviceUser = serviceUser;
        }

        /// <summary>
        ///  Create new pair discussion
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="receiverUser"></param>
        public DiscussionViewModel AddDiscussion(UserViewModel currentUser, UserViewModel receiverUser)
        {

            DiscussionViewModel discussion = new DiscussionViewModel
            {
            Name = new StringBuilder().Append(currentUser.FirstName).Append("_").Append(receiverUser.FirstName).ToString(),
            NumberOfDiscussionMember = NumberConstant.Two,
            DateLastNotif = DateTime.UtcNow

            };
            CreatedDataViewModel data = (CreatedDataViewModel)AddModelWithoutTransaction(discussion, null, null);
            DiscussionViewModel discussionChatViewModel = GetModelById(data.Id);
            return discussionChatViewModel;
        }
        /// <summary>
        ///  Create new group discussion
        /// </summary>
        /// <param name="currentUser"></param>
        public DiscussionViewModel AddGroupDiscussion(UserViewModel currentUser, List<UserDetailChatDiscussion> listOfGroupMembers, string discussionName)
        {
            StringBuilder generatedDiscussionName = new StringBuilder();
            if ("".Equals(discussionName))
            {
                foreach (UserDetailChatDiscussion userDetailChatDiscussion in listOfGroupMembers)
                {
                    if (generatedDiscussionName.Length < NumberConstant.TwoHundred)
                    {

                        generatedDiscussionName.Append(userDetailChatDiscussion.FullName.Substring(0, userDetailChatDiscussion.FullName.IndexOf(" "))).Append (", ");
                    }
                    else
                    {
                        generatedDiscussionName.Append("...");
                        break;
                    }
                }
                if (!("...".Equals(generatedDiscussionName.ToString().Substring(generatedDiscussionName.Length - 3))))
                {
                    generatedDiscussionName.Append(currentUser.FirstName);
                }

            }
            else
            {
                generatedDiscussionName.Append(discussionName);
            }


            DiscussionViewModel discussion = new DiscussionViewModel
            {
                Name = generatedDiscussionName.ToString(),
                NumberOfDiscussionMember = listOfGroupMembers.Count + 1,
                DateLastNotif = DateTime.UtcNow

            };
            CreatedDataViewModel data = (CreatedDataViewModel)AddModelWithoutTransaction(discussion, null, null);
            DiscussionViewModel discussionChatViewModel = GetModelById(data.Id);
            _serviceUserDiscussionChat.AddUserDiscussion(discussionChatViewModel.Id, currentUser.Id);
            foreach (UserDetailChatDiscussion userDetailChatDiscussion in listOfGroupMembers)
            {
                _serviceUserDiscussionChat.AddUserDiscussion(discussionChatViewModel.Id, userDetailChatDiscussion.Id);
            }
            return discussionChatViewModel;
        }

        /// <summary>
        ///  Create new message
        /// </summary>
        /// <param name="model"></param>
        public MessageChatViewModel AddMessage(MessageChatViewModel model)
        {
            model.Date = DateTime.UtcNow;
            CreatedDataViewModel data = (CreatedDataViewModel)_serviceMessageChat.AddModelWithoutTransaction(model, null, null);
            MessageChatViewModel messageChatViewModel = _serviceMessageChat.GetModelById(data.Id);
            return messageChatViewModel;
        }

        /// <summary>
        ///  Get Pair Discussion 
        /// </summary>
        /// <param name="idUser"></param>
        /// <param name="idReceiver"></param>
        public DiscussionViewModel GetDiscussion(int idUser, int idReceiver)
        {
            return GetModelsWithConditionsRelations(x => x.UserDiscussionChat.FirstOrDefault(y => y.IdUser == idUser) != null
           && x.UserDiscussionChat.FirstOrDefault(y => y.IdUser == idReceiver) != null
           && x.NumberOfDiscussionMember == NumberConstant.Two, x => x.UserDiscussionChat
            ).FirstOrDefault();
        }
        /// <summary>
        ///  Get Pair Discussion 
        /// </summary>
        /// <param name="idDiscussion"></param>
        public DiscussionViewModel GetDiscussionById(int idDiscussion, string userMail)
        {
            DiscussionViewModel discussion = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(y => y.Id == idDiscussion)
            .Include(y => y.UserDiscussionChat)
            .ThenInclude(y => y.IdUserNavigation)
            .Select(m => _builder.BuildEntity(m))
            .FirstOrDefault();
            UserViewModel currentUser = _serviceUser.GetModel(user => user.Email == userMail);
            UserDiscussionChatViewModel myUserDiscussion = discussion.UserDiscussionChat.Where((x) => x.IdUser == currentUser.Id).FirstOrDefault();
            if (myUserDiscussion.HasNotif == true)
            {
                // set the HasNotif as true in the discussion
                discussion.HasNotif = true;
            }
            MessageChatViewModel lastMsg = GetLastMessage(discussion.Id);
            if (lastMsg != null)
            {
                discussion.LastMsg = lastMsg;
            }
            return discussion;
        }

        /// <summary>
        ///  Get list discussions of current user
        /// </summary>
        /// <param name="idUser"></param>
        public List<DiscussionViewModel> GetListDiscussionsOfCurrentUser(int idUser)
        {
            BeginTransactionunReadUncommitted();
            List<DiscussionViewModel> myDiscussions = _entityRepo.GetAllWithConditionsQueryable(x => x.UserDiscussionChat.FirstOrDefault(y => y.IdUser == idUser) != null
           && x.NumberOfDiscussionMember >= NumberConstant.Two).Include(x => x.UserDiscussionChat).ThenInclude(x => x.IdUserNavigation)
              .OrderByDescending(x => x.DateLastNotif)
              .Select(m => _builder.BuildEntity(m))
              .ToList();
            // search if a discussion has a notif 
            foreach (DiscussionViewModel discussionChatViewModel in myDiscussions)
            {
                UserDiscussionChatViewModel myUserDiscussion = discussionChatViewModel.UserDiscussionChat.Where((x) => x.IdUser == idUser).FirstOrDefault();
                if (myUserDiscussion.HasNotif == true)
                {
                    // set the HasNotif as true in the discussion
                    discussionChatViewModel.HasNotif = true;
                }
                MessageChatViewModel lastMsg = GetLastMessage(discussionChatViewModel.Id);
                if (lastMsg != null)
                {
                    discussionChatViewModel.LastMsg = lastMsg;
                }
            }
            EndTransaction();
            return myDiscussions;
        }

        /// <summary>
        ///  Get list messages of pair discussion
        /// </summary>
        /// <param name="idDiscussion"></param>   
        /// <param name="pageNumber"></param>
        /// <param name="pageSize"></param>
        public DataSourceResult<MessageChatViewModel> GetDiscussionMessagesChat(int idDiscussion, int pageNumber, int pageSize)
        {
            DiscussionViewModel discussion = GetModelAsNoTracked(x => x.Id == idDiscussion, x => x.UserDiscussionChat);
            //Get list user discussion of discussion
            IList<UserDiscussionChatViewModel> userDiscussionList = discussion.UserDiscussionChat.ToList();
            IList<int> idUserDiscussion = userDiscussionList.Select(x => x.Id).ToList();
            //Get list message of discussion
            IList<MessageChatViewModel> messageChatList = _serviceMessageChat.FindModelBy(x => idUserDiscussion.Contains(x.IdUserDiscussion))
                                                            .OrderByDescending(x => x.Id).Skip(pageNumber * (pageSize - 1)
                                                    ).Take(pageSize).ToList();
            DataSourceResult<MessageChatViewModel> dataSourceResult = new DataSourceResult<MessageChatViewModel>();
            dataSourceResult.total = messageChatList.Count();
            dataSourceResult.data = messageChatList;
            return dataSourceResult;

        }

        /// <summary>
        ///  Get last message in pair discussion
        /// </summary>
        /// <param name="idDiscussion"></param>   
        public MessageChatViewModel GetLastMessage(int idDiscussion)
        {
            // Get the discussion
            DiscussionViewModel discussion = GetModelAsNoTracked(x => x.Id == idDiscussion, x => x.UserDiscussionChat);
            IList<UserDiscussionChatViewModel> userDiscussionList = discussion.UserDiscussionChat.ToList();
            IList<int> idUserDiscussion = userDiscussionList.Select(x => x.Id).ToList();
            // Get last message 
            MessageChatViewModel lastMessage = _serviceMessageChat.FindModelBy(x => idUserDiscussion.Contains(x.IdUserDiscussion))
                                                            .OrderByDescending(x => x.Id).FirstOrDefault();

            return lastMessage;
        }

        /// <summary>
        /// Mark notif as viewed 
        /// </summary>
        /// <param name="message"></param>
        /// <param name="userMail"></param>
        public void MarkNotifUserDiscussion(UserDiscussionChatViewModel userDiscussionChatViewModel, string userMail)
        {
            UserDiscussionChatViewModel oldUserDiscussionChatViewModel = _serviceUserDiscussionChat.GetModelAsNoTracked(x => x.Id == userDiscussionChatViewModel.Id);
            oldUserDiscussionChatViewModel.HasNotif = false;
            _serviceUserDiscussionChat.UpdateModel(oldUserDiscussionChatViewModel, null, userMail);
        }

        /// <summary>
        ///  Notif the receiver when he receives a new message
        /// </summary>
        /// <param name="message"></param>
        /// <param name="userMail"></param>
        public void NotifUserDiscussion(MessageChatViewModel message, string userMail)
        {

            UserDiscussionChatViewModel currentUserDiscussionChatViewModel = _serviceUserDiscussionChat.GetModel(x => x.Id == message.IdUserDiscussion);
            currentUserDiscussionChatViewModel.IdDiscussionNavigation = null;
            // Get discussion
            DiscussionViewModel currentDiscussion = GetModelWithRelationsAsNoTracked(x => x.Id == currentUserDiscussionChatViewModel.IdDiscussion, x => x.UserDiscussionChat);
            currentDiscussion.UserDiscussionChat = null;
            // Get receiver userDiscussion
            List<UserDiscussionChatViewModel> recieversUserDiscussionChatViewModel = _serviceUserDiscussionChat.GetAllModelsQueryable(x => x.Id != message.IdUserDiscussion && x.IdDiscussion == currentDiscussion.Id).ToList();
            // Notif discussion and receiver user discussion

            currentDiscussion.DateLastNotif = DateTime.UtcNow;
            recieversUserDiscussionChatViewModel.ForEach(x =>
            {
                x.HasNotif = true;
                _serviceUserDiscussionChat.UpdateModel(x, null, userMail);
            });
            UpdateModel(currentDiscussion, null, userMail);
        }

        public DiscussionViewModel AddNewMembers(ObjectToSaveViewModel objectToSave, string userMail)
        {
            List<UserDetailChatDiscussion> listOfNewGroupMembers = objectToSave.model.newMembers.ToObject<List<UserDetailChatDiscussion>>();
            int discussionId = objectToSave.model.idDiscussion;

            DiscussionViewModel discussion = GetDiscussionById(discussionId, userMail);

            discussion.NumberOfDiscussionMember += listOfNewGroupMembers.Count;
            if (!("...".Equals(discussion.Name.Substring(discussion.Name.Length - 3))))
            {
                discussion.Name += ", ";

                foreach (UserDetailChatDiscussion userDetailChatDiscussion in listOfNewGroupMembers)
                {
                    if (discussion.Name.Length < NumberConstant.TwoHundred)
                    {
                        discussion.Name += userDetailChatDiscussion.FullName.Substring(0, userDetailChatDiscussion.FullName.IndexOf(" ")) + ", ";
                    }
                    discussion.UserDiscussionChat.Add(new UserDiscussionChatViewModel
                    {
                        Id = 0,
                        IdUser = userDetailChatDiscussion.Id,
                        IdDiscussion = discussion.Id,
                        HasNotif = true

                    });
                }
                if (discussion.Name.Length >= NumberConstant.TwoHundred)
                {
                    discussion.Name += "...";
                }
            }
            else
            {
                foreach (UserDetailChatDiscussion userDetailChatDiscussion in listOfNewGroupMembers)
                {
                    discussion.UserDiscussionChat.Add(new UserDiscussionChatViewModel
                    {
                        Id = 0,
                        IdUser = userDetailChatDiscussion.Id,
                        IdDiscussion = discussion.Id,
                        HasNotif = true

                    });
                }

            }
            UpdateModel(discussion, null, userMail);

            return GetDiscussionById(discussion.Id, userMail);

        }
        public DiscussionViewModel UpdateChatGroupName(ObjectToSaveViewModel objectToSave, string userMail)
        {
            int idDiscussion = objectToSave.model.idDiscussion;
            string discussionName = objectToSave.model.discussionName;
            DiscussionViewModel discussion = GetDiscussionById(idDiscussion, userMail);
            discussion.Name = discussionName;

            UpdateModel(discussion, null, userMail);
            return discussion;
        }

        public DiscussionViewModel CreateChatGroup(ObjectToSaveViewModel objectToSave, string userMail)
        {
            List<UserDetailChatDiscussion> listOfGroupMembers = objectToSave.model.listOfGroupMembers.ToObject<List<UserDetailChatDiscussion>>();
            string discussionName = objectToSave.model.discussionName;
            DiscussionViewModel discussion;

            UserViewModel currentUser = _serviceUser.GetModel(user => user.Email == userMail);


            // create discussion 
            discussion = AddGroupDiscussion(currentUser, listOfGroupMembers, discussionName);
            discussion = GetDiscussionById(discussion.Id, userMail);
            return discussion;
        }

    }
}
