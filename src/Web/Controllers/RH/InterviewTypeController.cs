using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/interviewType")]
    public class InterviewTypeController : BaseController
    {
        public InterviewTypeController(IServiceProvider serviceProvider, ILogger<InterviewTypeController> logger)
           : base(serviceProvider, logger)
        {
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("FULL_RECRUITMENT")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }

        [HttpPost("getDataSourcePredicate"), Authorize("FULL_RECRUITMENT")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);

        }

        [HttpPost("getUnicity"), Authorize("FULL_RECRUITMENT,ADD_INTERVIEWTYPE")]
        public override bool GetUnicity([FromBody] object objectToCheck)
        {
            return base.GetUnicity(objectToCheck);
        }
    }
}
