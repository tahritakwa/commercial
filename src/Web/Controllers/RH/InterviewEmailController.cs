using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/interviewEmail")]
    public class InterviewEmailController : BaseController
    {
        public InterviewEmailController(IServiceProvider serviceProvider, ILogger<InterviewEmailController> logger)
          : base(serviceProvider, logger)
        {
        }

        [HttpPost("getDataSourcePredicate"), Authorize("INTERVIEW_MAIL_HISTORY")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
