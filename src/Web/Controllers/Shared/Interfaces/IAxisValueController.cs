using Microsoft.AspNetCore.Mvc;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Interfaces
{
    interface IAxisValueController : IBaseController
    {
        ResponseData GetAxisValueByAxis([FromBody]PredicateFormatViewModel model);
        ResponseData GetAxisValueByEntity(int? id);
    }
}
