using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/jobsParameters")]
    public class JobsParametersController : BaseController
    {
        public JobsParametersController(IServiceProvider serviceProvider, ILogger<JobsParametersController> logger)
          : base(serviceProvider, logger)
        {
        }
        [HttpPost("getModelByCondition"), Authorize("SHOW_JOBSPARAMETERS")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }
        }
}
