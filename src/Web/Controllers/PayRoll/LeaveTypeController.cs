using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/leaveType")]
    public class LeaveTypeController : BaseController
    {
        public LeaveTypeController(IServiceProvider serviceProvider, ILogger<LeaveTypeController> logger)
          : base(serviceProvider, logger)
        {
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_LEAVE,ADD_LEAVE,LIST_LEAVEREMAININGBALANCE,SHOW_LEAVE")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpGet("getDataDropdown"), Authorize("LIST_LEAVE")]

        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_LEAVEREMAININGBALANCE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
