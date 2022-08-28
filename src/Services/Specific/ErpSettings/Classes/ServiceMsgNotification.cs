using Microsoft.AspNetCore.SignalR;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Hubs;
using Services.Specific.Sales.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Utils;

namespace Services.Specific.ErpSettings.Classes
{
    /// <summary>
    /// Class SettingsService.
    /// </summary>
    /// <seealso cref="Infrastruture.Service.Service{ModelView.ErpSettings.ModuleViewModel, DataMapping.Models.Module}" />
    /// <seealso cref="SparkIt.Application.Services.ErpSettings.Interfaces.ISettingsService" />
    public class ServiceMsgNotification : Service<MsgNotificationViewModel, MsgNotification>, IServiceMsgNotification
    {
        internal readonly IServiceInformation _serviceInformation;
        internal readonly IServiceMessage _serviceMessage;
        internal readonly IServiceFinancialCommitment _serviceFinancialCommitment;
        internal readonly IRepository<Contract> _repoContract;
        internal readonly IRepository<User> _repoUser;
        private readonly IHubContext<NotificationHub> _reminderHubContext;
        private readonly IRepository<Document> _documentEntityRepo;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="entityRepo"></param>
        /// <param name="unitOfWork"></param>
        /// <param name="entityBuilder"></param>
        /// <param name="entityRepoUser"></param>
        /// <param name="entityRepoEntityAxisValues"></param>
        /// <param name="entityRepoEntity"></param>
        /// <param name="builderEntityAxisValues"></param>
        public ServiceMsgNotification(IRepository<MsgNotification> entityRepo,
            IUnitOfWork unitOfWork,
            IMsgNotificationBuilder entityBuilder,
            IHubContext<NotificationHub> reminderHubContext,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IRepository<User> repoUser,
            IServiceMessage serviceMessage,
            IEntityAxisValuesBuilder builderEntityAxisValues,
            IServiceInformation serviceInformation,
            IServiceFinancialCommitment serviceFinancialCommitment, IRepository<Contract> repoContract, IRepository<Document> documentEntityRepo)
            : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceInformation = serviceInformation;
            _serviceFinancialCommitment = serviceFinancialCommitment;
            _reminderHubContext = reminderHubContext;
            _repoContract = repoContract;
            _serviceMessage = serviceMessage;
            _documentEntityRepo = documentEntityRepo;
            _repoUser = repoUser;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="IdTagetUser"></param>
        /// <param name="lang"></param>
        /// <returns></returns>
        public List<NotificationItemViewModel> ListNotification(string userMail)
        {
            User user = _repoUser.GetSingleNotTracked(x => x.Email == userMail);
            List<MsgNotificationViewModel> notificationsMsg = FindModelsByNoTracked(x => x.IdTargetedUser == user.Id &&
                (x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.Validation || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.AlertFinancialCommitment
                || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.AlertEndContract || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.AlertAvailableProduct
                || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.AlertInterviewer || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.Document
                || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.AlertSharingDocument
                || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.TimesheetNotif),
                x => x.IdMsgNavigation, x => x.IdMsgNavigation.IdInformationNavigation).
                OrderByDescending(notif => notif.CreationDate).ToList();
            return PrepareNotifications(notificationsMsg);

        }

        public int ListNotificationcount(string userMail)
        {
            User user = _repoUser.GetSingleNotTracked(x => x.Email == userMail);
            int count = _entityRepo.GetAllAsNoTracking().Count(x => x.IdTargetedUser == user.Id && x.Viewed == false);
            return count;
        }
        /// <summary>
        /// prepare the list of notifications
        /// </summary>
        /// <param name="notificationsMsg"></param>
        /// <returns></returns>
        private List<NotificationItemViewModel> PrepareNotifications(List<MsgNotificationViewModel> notificationsMsg)
        {
            List<NotificationItemViewModel> result = new List<NotificationItemViewModel>();
            notificationsMsg.ForEach(notif =>
            {
                InformationViewModel information = notif.IdMsgNavigation.IdInformationNavigation;
                User creator = _repoUser.GetSingleNotTracked(x => x.Id == notif.IdMsgNavigation.IdCreator);
                User targetUser = _repoUser.GetSingleNotTracked(x => x.Id == notif.IdTargetedUser);
                string link = new StringBuilder().Append("/editOrder/").Append(notif.IdMsgNavigation.EntityReference).ToString();
                string entityReference = notif.IdMsgNavigation.EntityReference != NumberConstant.Zero ?
                 new StringBuilder().Append("/").Append(notif.IdMsgNavigation.EntityReference.ToString()).ToString() : null;
                switch (notif.IdMsgNavigation.TypeMessage)
                {
                    case (int)MessageTypeEnumerator.TimesheetNotif:
                    case (int)MessageTypeEnumerator.AlertSharingDocument:
                    case (int)MessageTypeEnumerator.AlertInterviewer:
                    case (int)MessageTypeEnumerator.Validation:
                    case (int)MessageTypeEnumerator.AlertMobilityRequest:
                    case (int)MessageTypeEnumerator.LeaveNotification:
                        result.Add(new NotificationItemViewModel()
                        {
                            IdNotification = notif.Id,
                            Link = (targetUser != null && targetUser.IsBtoB == true) ? link : new StringBuilder()
                            .Append(notif.IdMsgNavigation.IdInformationNavigation.Url).Append(entityReference).ToString(),
                            Viewed = notif.Viewed,
                            IdInfo = information.IdInfo,
                            CreationDate = notif.CreationDate,
                            CodeEntity = notif.IdMsgNavigation.CodeEntity,
                            NotificationType = notif.IdMsgNavigation.TypeMessage,
                            TranslationKey = information.TranslationKey,
                            Creator = new NotificationCreatorViewModel
                            {
                                FirstName = creator == null ? "Stark" : creator.FirstName,
                                LastName = creator == null ? "" : creator.LastName
                            },
                            Parameters = JsonParser.ValidateJSON(notif.IdMsgNavigation.CodeEntity) ? JsonParser.GetParameters(notif.IdMsgNavigation.CodeEntity) : null
                        });
                        break;

                    case (int)MessageTypeEnumerator.AlertEndContract:
                        NotificationItemEndContractViewModel notificationItemEndContractViewModel = getNotificationItemEndContractViewModel(notif.IdMsgNavigation.EntityReference);
                        result.Add(new NotificationItemViewModel()
                        {
                            IdNotification = notif.Id,
                            Link = new StringBuilder().Append(notif.IdMsgNavigation.IdInformationNavigation.Url).Append("/").Append(notificationItemEndContractViewModel.IdEmployee).ToString(),
                            Viewed = notif.Viewed,
                            IdInfo = information.IdInfo,
                            CreationDate = notif.CreationDate,
                            CodeEntity = notif.IdMsgNavigation.CodeEntity,
                            NotificationType = notif.IdMsgNavigation.TypeMessage,
                            TranslationKey = information.TranslationKey,
                            Creator = new NotificationCreatorViewModel
                            {
                                FirstName = creator == null ? "Stark" : creator.FirstName,
                                LastName = creator == null ? "" : creator.LastName
                            },
                            DataOfEndContract = notificationItemEndContractViewModel
                        });
                        break;
                    case (int)MessageTypeEnumerator.AlertFinancialCommitment:
                        FinancialCommitmentViewModel financialCommitment = _serviceFinancialCommitment.GetModelWithRelationsAsNoTracked
                        (x => x.Id == notif.IdMsgNavigation.EntityReference, x => x.IdDocumentNavigation);
                        if (financialCommitment != null)
                        {
                            result.Add(new NotificationItemViewModel()
                            {
                                IdNotification = notif.Id,
                                Link = new StringBuilder().Append(notif.IdMsgNavigation.IdInformationNavigation.Url).ToString(),
                                Viewed = notif.Viewed,
                                IdInfo = information.IdInfo,
                                CreationDate = notif.CreationDate,
                                CodeEntity = notif.IdMsgNavigation.CodeEntity,
                                NotificationType = notif.IdMsgNavigation.TypeMessage,
                                FinancialCommitmentDate = financialCommitment.CommitmentDate,
                                IdTiers = financialCommitment.IdDocumentNavigation.IdTiers,
                                TranslationKey = information.TranslationKey,
                                Creator = new NotificationCreatorViewModel { FirstName = "Stark" }

                            });
                        }
                        break;

                    case (int)MessageTypeEnumerator.AlertAvailableProduct:
                    case (int)MessageTypeEnumerator.Document:
                        Document document = _documentEntityRepo.GetSingleNotTracked(x => x.Id == notif.IdMsgNavigation.EntityReference);
                        if (document != null)
                        {
                            result.Add(new NotificationItemViewModel()
                            {
                                IdNotification = notif.Id,
                                Link = (targetUser != null && targetUser.IsBtoB == true) ? link :
                                 new StringBuilder().Append(notif.IdMsgNavigation.IdInformationNavigation.Url).Append("/").Append(document.Id).Append("/").Append(document.IdDocumentStatus).ToString(),
                                Viewed = notif.Viewed,
                                IdInfo = information.IdInfo,
                                CreationDate = notif.CreationDate,
                                CodeEntity = notif.IdMsgNavigation.CodeEntity,
                                NotificationType = notif.IdMsgNavigation.TypeMessage,
                                TranslationKey = information.TranslationKey,
                                Creator = new NotificationCreatorViewModel { FirstName = "Stark" }

                            });
                        }
                        break;
                    default:
                        break;
                }

            });
            return result;
        }


        private NotificationItemEndContractViewModel getNotificationItemEndContractViewModel(int idContract)
        {
            Contract contract = _repoContract.GetSingleWithRelationsNotTracked(x => x.Id == idContract, x => x.IdEmployeeNavigation);
            return new NotificationItemEndContractViewModel()
            {
                FullName = contract.IdEmployeeNavigation.FullName,
                DateEndContract = contract.EndDate.Value.ToShortDateString(),
                IdEmployee = contract.IdEmployee
            };
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="notificationId"></param>
        /// <param name="idTargetUser"></param>
        public void DropNotification(int notificationId, int idTargetUser)
        {
            try
            {
                string userMail = _repoUser.GetSingleNotTracked(u => u.Id == idTargetUser).Email;
                base.DeleteModel(notificationId, typeof(MsgNotification).ToString(), userMail);
            }
            catch (Exception)
            {
                throw;
            }

        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="notificationId"></param>
        /// <param name="idTargetUser"></param>
        public void MarkNotificationAsRead(int notificationId, int idTargetUser)
        {
            try
            {
                BeginTransaction();
                MsgNotification notification = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(notif => notif.Id == notificationId).First();
                if (notification != null)
                {
                    notification.Viewed = true;
                    _entityRepo.Update(notification);
                    _unitOfWork.Commit();
                }
                EndTransaction();
            }
            catch (Exception ex)
            {
                _unitOfWork.RollbackTransaction();
                throw ex;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="idMessage"></param>
        /// <returns></returns>
        public NotificationItemViewModel GetNotificationItem(string userMail, int idMessage)
        {
            User user = _repoUser.GetSingleNotTracked(x => x.Email == userMail);
            MsgNotificationViewModel lastNotification = FindModelsByNoTracked(n => n.IdTargetedUser == user.Id, n => n.IdMsgNavigation, n => n.IdMsgNavigation.IdInformationNavigation).LastOrDefault();
            if (lastNotification != null)
            {
                User creator = _repoUser.GetSingleNotTracked(x => x.Id == lastNotification.IdMsgNavigation.IdCreator);
                if (creator == null)
                {
                    return null;
                }
                NotificationItemViewModel notif = new NotificationItemViewModel()
                {
                    IdNotification = lastNotification.Id,

                    Viewed = lastNotification.Viewed,
                    IdInfo = lastNotification.IdMsgNavigation.IdInformationNavigation.IdInfo,
                    CreationDate = lastNotification.CreationDate,
                    CodeEntity = lastNotification.IdMsgNavigation.CodeEntity,
                    NotificationType = lastNotification.IdMsgNavigation.TypeMessage,
                    TranslationKey = lastNotification.IdMsgNavigation.IdInformationNavigation.TranslationKey,
                    Creator = new NotificationCreatorViewModel { FirstName = creator!=null ? creator.FirstName :"", LastName = creator != null ? creator.LastName :"" },
                };
                var document = _documentEntityRepo.GetSingleNotTracked(x => x.Id == lastNotification.IdMsgNavigation.EntityReference);
                if (document != null && document.DocumentTypeCode != DocumentEnumerator.PurchaseRequest && lastNotification.IdMsgNavigation.EntityReference != NumberConstant.One)
                {
                    if (user.IsBtoB == true)
                    {
                        notif.Link = new StringBuilder().Append("/editOrder/").Append(lastNotification.IdMsgNavigation.EntityReference).ToString();
                    }
                    else
                    {
                        notif.Link = new StringBuilder().Append(lastNotification.IdMsgNavigation.IdInformationNavigation.Url).Append("/").Append(lastNotification.IdMsgNavigation.EntityReference)
                   .Append("/").Append(document.IdDocumentStatus).ToString();
                    }

                }
                else
                {
                    notif.Link = new StringBuilder().Append(lastNotification.IdMsgNavigation.IdInformationNavigation.Url).Append("/").Append(lastNotification.IdMsgNavigation.EntityReference).ToString();
                }

                if (JsonParser.ValidateJSON(lastNotification.IdMsgNavigation.CodeEntity))
                {
                    notif.Parameters = JsonParser.GetParameters(lastNotification.IdMsgNavigation.CodeEntity);
                }
                return notif;
            }
            else
            {
                return null;
            }


        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="idTargetUser"></param>
        public void MarkAllAsRead(int idTargetUser)
        {
            try
            {
                List<MsgNotification> notifications = _entityRepo.GetAllWithConditionsRelations(notif => notif.IdTargetedUser == idTargetUser && notif.Viewed == false, x => x.IdMsgNavigation,
                    x => x.IdMsgNavigation.IdInformationNavigation).ToList();
                foreach (MsgNotification notification in notifications)
                {
                    notification.Viewed = true;
                    _entityRepo.Update(notification);
                    _unitOfWork.Commit();
                }
            }
            catch (Exception)
            {
                _unitOfWork.RollbackTransaction();
                throw;
            }
        }
        /// <summary>
        /// Lazy load notifications
        /// </summary>
        /// <param name="userMail"></param>
        /// <param name="pageNumber"></param>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        public List<NotificationItemViewModel> ListNotificationWithPagination(string userMail, int pageNumber, int pageSize)
        {
            try
            {
                User user = _repoUser.GetSingleNotTracked(x => x.Email == userMail);
                List<MsgNotificationViewModel> notificationsMsg = FindModelsByNoTracked(x => x.IdTargetedUser == user.Id &&
                    (x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.Validation || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.AlertFinancialCommitment
                    || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.AlertEndContract || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.AlertAvailableProduct
                    || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.AlertInterviewer || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.Document
                    || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.AlertSharingDocument
                    || x.IdMsgNavigation.TypeMessage == (int)MessageTypeEnumerator.TimesheetNotif),
                    x => x.IdMsgNavigation, x => x.IdMsgNavigation.IdInformationNavigation)
                    .OrderByDescending(notif => notif.CreationDate).Skip(pageNumber * (pageSize - 1))
                    .Take(pageSize).ToList();
                return PrepareNotifications(notificationsMsg);
            }
            catch (Exception e)
            {
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }

        }

        public void PrepareAndNotifyUsersWithoutTransaction(string informationType, int idEntityReference, string codeEntity,
            int typeMessage, string userMail, dynamic specificData = null, List<User> listTargetUsersParam = null, string codeCompany = null)
        {
            // Get Information by type
            InformationViewModel information = _serviceInformation.GetModelsWithConditionsRelations(x => x.Type == informationType).FirstOrDefault();
            // Get message
            MessageViewModel message = _serviceMessage.GetModelAsNoTracked(x => x.EntityReference == idEntityReference
            && x.CodeEntity == codeEntity
            && x.IdInformation == information.IdInfo, x => x.IdInformationNavigation);
            if (message == null)
            {
                message = new MessageViewModel
                {
                    IdCreator = 1,
                    IdInformation = information.IdInfo,
                    EntityReference = idEntityReference,
                    CodeEntity = codeEntity,
                    TypeMessage = typeMessage
                };
                CreatedDataViewModel addedMessage = (CreatedDataViewModel)_serviceMessage.AddModelWithoutTransaction(message, null, userMail);
                List<User> listTargetUsers = listTargetUsersParam;
                if (listTargetUsers == null)
                {
                    listTargetUsers = _serviceInformation.GetTargetedUsersByInformation(information.IdInfo).ToList();
                }
                foreach (User user in listTargetUsers)
                {
                    MsgNotificationViewModel msgNotification = new MsgNotificationViewModel
                    {
                        IdMsg = addedMessage.Id,
                        Viewed = false,
                        CreationDate = DateTime.Now,
                        IdTargetedUser = user.Id,
                    };
                    AddModelWithoutTransaction(msgNotification, null, userMail);
                }
                MsgNotificationViewModel messageNotification = GetModelsWithConditionsRelations(x => x.IdMsg == addedMessage.Id, x => x.IdMsgNavigation).FirstOrDefault();
                if (messageNotification != null)
                {
                    messageNotification.IdMsgNavigation.IdInformationNavigation = information;
                    NotificationHub.SendNoticationsReminder(listTargetUsers.Select(x => x.Email).ToList(), messageNotification, _reminderHubContext, specificData, codeCompany);
                }
            }
        }

        public void PrepareAndNotifyUser(string informationType, int idEntityReference, string codeEntity,
            int typeMessage, string userMail, dynamic specificData = null, List<int> listTargetUsersIdsParam = null, string codeCompany = null)
        {
            List<User> listUser = new List<User>(); 
            foreach (int idUser in listTargetUsersIdsParam)
            {
                listUser.Add(_repoUser.GetSingleNotTracked(x => x.Id == idUser));
            }
            PrepareAndNotifyUsersWithoutTransaction(informationType, idEntityReference, codeEntity,
            typeMessage, userMail, specificData, listUser, codeCompany);
        }

    }
}
