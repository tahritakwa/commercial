using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.ErpSettings.Interfaces
{
    public interface IServiceMsgNotification : IService<MsgNotificationViewModel, MsgNotification>
    {
        List<NotificationItemViewModel> ListNotification(string userMail);
        void DropNotification(int notificationId, int idTargetUser);
        void MarkNotificationAsRead(int notificationId, int idTargetUser);
        NotificationItemViewModel GetNotificationItem(string userMail, int idMessage);
        void MarkAllAsRead(int idTargetUser);
        List<NotificationItemViewModel> ListNotificationWithPagination(string userMail, int pageNumber, int pageSize);
        int ListNotificationcount(string userMail);
        void PrepareAndNotifyUsersWithoutTransaction(string informationType, int idEntityReference, string codeEntity,
            int typeMessage, string userMail, dynamic specificData = null, List<User> listTargetUsersParam = null, string codeCompany = null);
        void PrepareAndNotifyUser(string informationType, int idEntityReference, string codeEntity,
            int typeMessage, string userMail, dynamic specificData = null, List<int> listTargetUsersIdsParam = null, string codeCompany = null);
    }
}
