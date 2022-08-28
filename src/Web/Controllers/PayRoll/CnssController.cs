using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/cnss")]
    public class CnssController : BaseController
    {
        public CnssController(IServiceProvider serviceProvider, ILogger<CnssController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpGet("getDataDropdown"), Authorize("LIST_CONTRACT,ADD_RECRUITMENT,FULL_RECRUITMENT")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_CONTRACT,ADD_EMPLOYEE,UPDATE_CONTRACT,UPDATE_EMPLOYEE,LIST_CNSSDECLARATION,ADD_CNSSDECLARATION,ADD_BENEFITINKIND,SHOW_BENEFITINKIND,ADD_BONUS,SHOW_BONUS")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
    }
}
