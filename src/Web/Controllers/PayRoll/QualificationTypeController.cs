using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/qualificationType")]
    public class QualificationTypeController : BaseController
    {
        public QualificationTypeController(IServiceProvider serviceProvider, ILogger<QualificationTypeController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpGet("getDataDropdown"), Authorize("ADD_RECRUITMENTREQUEST,ADD_RECRUITMENTOFFER,UPDATE_RECRUITMENTREQUEST,UPDATE_RECRUITMENTOFFER,LIST_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT")]

        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }

        [HttpPost("getDataSourcePredicate"), Authorize("ADD_RECRUITMENT")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_RECRUITMENTREQUEST,ADD_RECRUITMENTOFFER,UPDATE_RECRUITMENTREQUEST,UPDATE_RECRUITMENTOFFER,ADD_RECRUITMENT,UPDATE_RECRUITMENT,ADD_CANDIDATE,UPDATE_CANDIDATE")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
    }
}
