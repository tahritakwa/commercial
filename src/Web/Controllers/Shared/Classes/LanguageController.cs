using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/language")]
    public class LanguageController : BaseController
    {
        public LanguageController(IServiceProvider serviceProvider, ILogger<LanguageController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpGet("getDataDropdown"), Authorize("ADD_RECRUITMENTREQUEST,ADD_RECRUITMENTOFFER,ADD_RECRUITMENT")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }

        [HttpPost("getDataSourcePredicate"), Authorize("ADD_LANGUAGE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_RECRUITMENTREQUEST,ADD_RECRUITMENTOFFER,ADD_RECRUITMENT,UPDATE_RECRUITMENTREQUEST,UPDATE_RECRUITMENTOFFER,UPDATE_RECRUITMENT")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);

        }

        [HttpPost("getUnicity"), Authorize("ADD_LANGUAGE,UPDATE_LANGUAGE")]
        public override bool GetUnicity([FromBody] object objectToCheck)
        {
            return base.GetUnicity(objectToCheck);
        }

    }
}
