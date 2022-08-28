using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/skillsFamily")]
    public class SkillsFamilyController : BaseController
    {
        public SkillsFamilyController(IServiceProvider serviceProvider, ILogger<SkillsFamilyController> logger)
          : base(serviceProvider, logger)
        {
        }
        [HttpGet("get"), Authorize("VIEW_SKILLS_MATRIX")]
        public override ResponseData Get()
        {
            return base.Get();
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("VIEW_SKILLS_MATRIX,ADD_SKILL,UPDATE_SKILLS")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpPost("getDataSourcePredicate"), Authorize("ADD_SKILLS,UPDATE_SKILLS")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
        [HttpPost("getUnicity"), Authorize("ADD_SKILLS,UPDATE_SKILLS")]
        public override bool GetUnicity([FromBody] object objectToCheck)
        {
            return base.GetUnicity(objectToCheck);
        }
        [HttpPost("insert"), Authorize("ADD_SKILLS,UPDATE_SKILLS")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }
        [HttpPut("update"), Authorize("ADD_SKILLS,UPDATE_SKILLS")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
    }
}
