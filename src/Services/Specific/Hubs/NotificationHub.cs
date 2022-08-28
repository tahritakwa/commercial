using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using ViewModels.DTO.Common;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Sales;

namespace Services.Specific.Hubs
{
    public class NotificationHub : BaseHub
    {
        #region Fields
        /// <summary>
        /// _serviceMsgNotification
        /// </summary>
        private readonly IServiceMsgNotification _serviceMsgNotification;
        /// <summary>
        /// FinantialCommitement service
        /// </summary>
        private static IServiceFinancialCommitment _sericeFinantialCommitement;
        /// <summary>
        /// user service
        /// </summary>
        private static IServiceInformation _serviceInformation;
        private static IServiceCompany _serviceCompany;
        private readonly ILogger<NotificationHub> _logger;
        private readonly IRepository<User> _entityRepoUser;


        #endregion
        /// <summary>
        /// Ctor
        /// </summary>
        /// <param name="serviceMsgNotification"></param>
        /// <param name="sericeFinantialCommitement"></param>
        /// <param name="hubContext"></param>
        /// <param name="serviceUser"></param>
        public NotificationHub(IServiceMsgNotification serviceMsgNotification,
            IServiceFinancialCommitment sericeFinantialCommitement,
            ILogger<NotificationHub> logger,
             IServiceCompany serviceCompany,
             IRepository<User> entityRepoUser,
             IServiceInformation serviceInformation)
        {
            _serviceMsgNotification = serviceMsgNotification;
            _serviceInformation = serviceInformation;
            _sericeFinantialCommitement = sericeFinantialCommitement;
            _serviceCompany = serviceCompany;
            _logger = logger;
            _entityRepoUser = entityRepoUser;
        }
        #region Methodes
        /// <summary>
        /// Override OnConnectedAsync
        /// </summary>
        /// <returns>Task</returns>
        public override Task OnConnectedAsync()
        {
            try
            {
                var httpContext = GetHttpContext();

                var user = new UserDetail()
                {
                    ConnectionId = Context.ConnectionId,
                    UserMail = httpContext.Request.Query["userMail"]
                };
                ConnectedUsers.Add(user);


                //cette requete permet de récuperer la liste des connectionsIds et de chercher les emails a notifier et connecté en meme temps
                if (user.ConnectionId != null)
                {
                    return Clients.Client(user.ConnectionId).SendAsync("OnConnectedAsync");
                }
                return base.OnConnectedAsync();
            }
            catch (Exception e)
            {
                _logger.LogError("<<<<<  connect to hub " + e.Message + e.InnerException);
                return null;
            }

        }
        /// <summary>
        /// Send Notification To MultipleUsers
        /// </summary>
        /// <param name="dynamicObj"></param>
        /// <returns>Task</returns>
        public Task SendNotificationToMultipleUsers(string dynamicObj)
        {
            var sendedObject = JsonConvert.DeserializeObject<SendedObject>(dynamicObj);
            //cette requete permet de récuperer la liste des connectionsIds et de chercher les emails a notifier et connecté en meme temps
            var connectionIds = (IReadOnlyList<string>)ConnectedUsers.Where(x => !sendedObject.Mails.Contains(x.UserMail)).Select(x => x.ConnectionId).ToList();
            List<NotificationItemViewModel> notificationToSend = new List<NotificationItemViewModel>();
            if (sendedObject.Mails.Any())
            {
                var userList = _entityRepoUser.GetAllAsNoTracking().Where(x => sendedObject.Mails.Contains(x.Email) && x.IsBtoB == true).ToList();
                if (userList.Any())
                {
                    notificationToSend.Add(_serviceMsgNotification.GetNotificationItem(userList.First(x => x.IsBtoB == true).Email, int.Parse(sendedObject.Message)));
                }
                else
                {
                    notificationToSend.Add(_serviceMsgNotification.GetNotificationItem(sendedObject.Mails[0], int.Parse(sendedObject.Message)));
                }

                if (connectionIds.Any())
                {
                    foreach (var item in notificationToSend)
                    {

                        Clients.AllExcept(connectionIds).SendAsync("SendNotificationToMultipleUsers", JsonConvert.SerializeObject(item));
                    }
                }
                else
                {
                    foreach (var item in notificationToSend)
                    {

                        Clients.All.SendAsync("SendNotificationToMultipleUsers", JsonConvert.SerializeObject(item));
                    }
                }
            }
            return Task.CompletedTask;
        }
        /// <summary>
        /// Send Financial Commitment Reminder Notications
        /// </summary>
        /// <param name="notificationToSend"></param>
        /// <param name="reminderHubContext"></param>
        /// <returns></returns>
        public static Task SendFinancialCommitmentReminderNotications(MsgNotification notificationToSend, IHubContext<NotificationHub> reminderHubContext)
        {
            if (ConnectedUsers == null || !ConnectedUsers.Any())
            {
                return Task.Delay(0);
            }
            else
            {
                List<string> mailsTargetedUsers = _serviceInformation.GetTargetedUsersByInformation(notificationToSend.IdMsgNavigation.IdInformation).Select(x => x.Email).ToList();
                var connectionIds = (IReadOnlyList<string>)ConnectedUsers.Where(x => !mailsTargetedUsers.Contains(x.UserMail)).Select(x => x.ConnectionId).ToList();
                FinancialCommitmentViewModel financialCommitment = _sericeFinantialCommitement.GetModelWithRelations(x => x.Id == notificationToSend.IdMsgNavigation.EntityReference, x => x.IdDocumentNavigation);
                NotificationItemViewModel notificationItemViewModel = new NotificationItemViewModel()
                {
                    IdNotification = notificationToSend.Id,
                    Link = new StringBuilder().Append(notificationToSend.IdMsgNavigation.IdInformationNavigation.Url).ToString() + "/" + financialCommitment.IdDocumentNavigation.IdDocumentStatus + "/" + financialCommitment.IdDocumentNavigation.Id,
                    Viewed = notificationToSend.Viewed,
                    IdInfo = notificationToSend.IdMsgNavigation.IdInformationNavigation.IdInfo,
                    CreationDate = notificationToSend.CreationDate,
                    CodeEntity = notificationToSend.IdMsgNavigation.CodeEntity,
                    NotificationType = notificationToSend.IdMsgNavigation.TypeMessage,
                    FinancialCommitmentDate = financialCommitment.CommitmentDate,
                    IdTiers = financialCommitment.IdDocumentNavigation.IdTiers
                };
                if (connectionIds.Any())
                {
                    return reminderHubContext.Clients.AllExcept(connectionIds).SendAsync("SendFinancialCommitmentReminderNotications", JsonConvert.SerializeObject(notificationItemViewModel));
                }
                else
                {
                    return reminderHubContext.Clients.All.SendAsync("SendFinancialCommitmentReminderNotications", JsonConvert.SerializeObject(notificationItemViewModel));
                }
            }
        }

        public static Task SendNoticationsReminder(List<string> mailsTargetedUsers, MsgNotificationViewModel notificationToSend, IHubContext<NotificationHub> reminderHubContext, dynamic specificData = null, string codeCompany = null)
        {
            if (ConnectedUsers == null || !ConnectedUsers.Any())
            {
                return Task.Delay(0);
            }
            else
            {
                var connectionIds = (IReadOnlyList<string>)ConnectedUsers.Where(x => x != null && mailsTargetedUsers.Contains(x.UserMail)).Select(x => x.ConnectionId).ToList();
                NotificationItemViewModel notificationItemViewModel = new NotificationItemViewModel()
                {
                    IdNotification = notificationToSend.Id,
                    Link = new StringBuilder().Append(notificationToSend.IdMsgNavigation.IdInformationNavigation.Url).Append("/").Append(notificationToSend.IdMsgNavigation.EntityReference).ToString(),
                    Viewed = notificationToSend.Viewed,
                    IdInfo = notificationToSend.IdMsgNavigation.IdInformationNavigation.IdInfo,
                    CreationDate = notificationToSend.CreationDate,
                    CodeEntity = notificationToSend.IdMsgNavigation.CodeEntity,
                    NotificationType = notificationToSend.IdMsgNavigation.TypeMessage,
                    TranslationKey = notificationToSend.IdMsgNavigation.IdInformationNavigation.TranslationKey,
                    Creator = new NotificationCreatorViewModel { FirstName = "Stark" },
                    ConnectedCompany = codeCompany
                };
                switch (notificationToSend.IdMsgNavigation.TypeMessage)
                {
                    case (int)MessageTypeEnumerator.AlertEndContract:
                        {
                            notificationItemViewModel.DataOfEndContract = (NotificationItemEndContractViewModel)specificData;
                            notificationItemViewModel.Link = new StringBuilder().Append(notificationItemViewModel.Link).Append("/").Append(notificationItemViewModel.DataOfEndContract.IdEmployee).ToString();
                            break;
                        }
                    case (int)MessageTypeEnumerator.AlertAvailableProduct:
                        {
                            notificationItemViewModel.Parameters = (IDictionary<string, dynamic>)specificData;
                            var status = notificationItemViewModel.Parameters[Constants.STATUS];
                            notificationItemViewModel.Link = new StringBuilder().Append(notificationItemViewModel.Link).Append("/").Append(notificationToSend.IdMsgNavigation.EntityReference)
                                .Append("/").Append(status).ToString();

                            break;
                        }

                    case (int)MessageTypeEnumerator.AlertInterviewer:
                    case (int)MessageTypeEnumerator.AlertMobilityRequest:
                        {
                            notificationItemViewModel.Link = new StringBuilder().Append(notificationItemViewModel.Link).Append("/").Append(notificationToSend.IdMsgNavigation.EntityReference).ToString();
                            notificationItemViewModel.Parameters = (IDictionary<string, dynamic>)specificData;
                            break;
                        }
                    case (int)MessageTypeEnumerator.AlertSharingDocument:
                    case (int)MessageTypeEnumerator.NotifExpenseReport:
                    case (int)MessageTypeEnumerator.TimesheetNotif:
                    case (int)MessageTypeEnumerator.LeaveNotification:
                    case (int)MessageTypeEnumerator.DocumentRequestNotification:
                        {
                            notificationItemViewModel.Parameters = (IDictionary<string, dynamic>)specificData;
                            break;
                        }
                    case (int)MessageTypeEnumerator.AlertPlannedInventoryDocument:
                        {
                            notificationItemViewModel.Parameters = (IDictionary<string, dynamic>)specificData;
                            break;
                        }
                    default:
                        break;

                }

                if (connectionIds.Any())
                {
                    return reminderHubContext.Clients.Clients(connectionIds).SendAsync("SendNoticationsReminder", JsonConvert.SerializeObject(notificationItemViewModel));
                }
                else
                {
                    return reminderHubContext.Clients.All.SendAsync("SendNoticationsReminder", JsonConvert.SerializeObject(notificationItemViewModel));
                }
            }

        }
        #endregion
    }
}
