using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/ruleUniqueReference")]
    public class RuleUniqueReferenceController : BaseController
    {
        public RuleUniqueReferenceController(IServiceProvider serviceProvider, ILogger<VariableController> logger)
            : base(serviceProvider, logger)
        {
            _logger = logger;
        }
        [HttpPost("getUnicity"), Authorize("ADD_VARIABLE,SHOW_VARIABLE,ADD_SALARYRULE,SHOW_SALARYRULE")]
        public override bool GetUnicity([FromBody] object objectToCheck)
        {
            return base.GetUnicity(objectToCheck);
        }
    }
}
