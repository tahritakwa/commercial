using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/exitReason")]
    public class ExitReasonController : BaseController
    {

        public ExitReasonController(IServiceProvider serviceProvider,
            ILogger<ExitReasonController> logger)
            : base(serviceProvider, logger)
        {

        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_EXITEMPLOYEE,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);

        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_EXITEMPLOYEE,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);

        }
    }
}
