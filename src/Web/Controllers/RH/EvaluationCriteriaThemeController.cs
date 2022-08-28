using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/evaluationCriteriaTheme")]
    public class EvaluationCriteriaThemeController : BaseController
    { /// <summary>
      /// Constructor
      /// </summary>
      /// <param name="serviceProvider"></param>
      /// <param name="logger"></param>
      /// <param name="serviceCandidacy"></param>
      /// <param name="serviceUser"></param>
        public EvaluationCriteriaThemeController(IServiceProvider serviceProvider, ILogger<EvaluationCriteriaThemeController> logger)
            : base(serviceProvider, logger)
        {
        }

        [HttpGet("get"), Authorize("ADD_RECRUITMENT")]
        public override ResponseData Get()
        {
            return base.Get();
        }
    }
}
