using Microsoft.AspNetCore.Mvc;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Inventory.Interfaces
{
    interface IItemController : IBaseController
    {
        ResponseData GetItemsListByWarehouse([FromBody] PredicateFormatViewModel model);
    }
}
