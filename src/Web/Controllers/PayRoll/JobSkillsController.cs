using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/jobskills")]
    public class JobSkillsController : BaseController
    {

        public JobSkillsController(IServiceProvider serviceProvider, ILogger<TeamController> logger)
            : base(serviceProvider, logger)
        {
            _logger = logger;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("FULL_RECRUITMENT,LIST_RECRUITMENT")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
