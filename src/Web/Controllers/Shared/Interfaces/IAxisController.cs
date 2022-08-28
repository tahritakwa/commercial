using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Interfaces
{
    interface IAxisController : IBaseController
    {
        ResponseData GetTreeListAxis(int? id);
        ResponseData GetAxesHierarchy();
        ResponseData GetAxisByEntity(string id);
    }
}
