using Microsoft.AspNetCore.Mvc;
using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.ErpSettings.Interfaces
{
    interface INotificationController : IBaseController
    {
        ResponseData GetNotificationInput([FromBody]dynamic model);
    }
}
