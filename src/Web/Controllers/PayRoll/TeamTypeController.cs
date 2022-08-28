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
    [Route("api/teamType")]
    public class TeamTypeController : BaseController
    {
        public TeamTypeController(IServiceProvider serviceProvider, ILogger<TeamTypeController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpGet("getDataDropdown"), Authorize("LIST_TEAM")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_TEAM")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("insert"), Authorize("ADD_TEAM")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }

        [HttpDelete("delete/{id}"), Authorize("ADD_TEAM")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }

        [HttpPut("update"), Authorize("ADD_TEAM")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_TEAM,UPDATE_TEAM,SHOW_TEAM")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
    }
}
