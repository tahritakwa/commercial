using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/grade")]
    public class GradeController : BaseController
    {
        public GradeController(IServiceProvider serviceProvider, ILogger<GradeController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpGet("getDataDropdown"), Authorize("LIST_EMPLOYEE")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_EMPLOYEE,UPDATE_EMPLOYEE,SHOW_EMPLOYEE")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpPost("getDataSourcePredicate"), Authorize("ADD_EMPLOYEE,UPDATE_EMPLOYEE,SHOW_EMPLOYEE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
