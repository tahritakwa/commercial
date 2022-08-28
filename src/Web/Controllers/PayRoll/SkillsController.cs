using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/skills")]
    public class SkillsController : BaseController
    {
        public SkillsController(IServiceProvider serviceProvider, ILogger<SkillsController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_RECRUITMENTREQUEST,ADD_RECRUITMENTOFFER,ADD_RECRUITMENT,ADD_TRAINING,UPDATE_TRAINING,UPDATE_RECRUITMENTREQUEST,UPDATE_RECRUITMENTOFFER," +
            "UPDATE_RECRUITMENT,VIEW_SKILLS_MATRIX,SHOW_REVIEW,ADD_CATEGORY,EDIT_CATEGORY,SHOW_TRAINING")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }

        [HttpPost("getDataSourcePredicate"), Authorize("VIEW_SKILLS_MATRIX,ADD_SKILLS,ADD_EMPLOYEE,UPDATE_EMPLOYEE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("getUnicity"), Authorize("ADD_SKILLS,UPDATE_SKILLS")]
        public override bool GetUnicity([FromBody] object objectToCheck)
        {
            return base.GetUnicity(objectToCheck);
        }
        [HttpGet("get"), Authorize("ADD_TRAINER")]
        public override ResponseData Get()
        {
            return base.Get();
        }

        [HttpGet("getDataDropdown"), Authorize("ADD_EMPLOYEE,UPDATE_EMPLOYEE,UPDATE_JOB,ADD_JOB")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }

    }
}
