using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.ErpSettings.Interfaces
{
    interface IMsgNotificationController : IBaseController
    {
        ResponseData DropNotification(dynamic model);
        ResponseData MarkNotificationAsRead(dynamic paramsObject);
        ResponseData MarkAllAsRead(dynamic paramsObject);
        ResponseData ListNotificationWithPagination(dynamic paramsObject);
    }
}
