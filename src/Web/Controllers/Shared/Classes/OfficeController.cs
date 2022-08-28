using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/office")]
    public class OfficeController : BaseController
    {
        public OfficeController(IServiceProvider serviceProvider, ILogger<OfficeController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_EMPLOYEE,ADD_RECRUITMENTREQUEST,ADD_RECRUITMENTOFFER,UPDATE_RECRUITMENTREQUEST,UPDATE_RECRUITMENTOFFER,LIST_RECRUITMENT,ADD_RECRUITMENT," +
            "UPDATE_RECRUITMENT,ADD_CANDIDATE,UPDATE_CANDIDATE")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
    }
}
