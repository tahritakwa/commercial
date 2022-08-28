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
    [Route("api/additionalHour")]
    public class AdditionalHourController : BaseController
    {
        public AdditionalHourController(IServiceProvider serviceProvider, ILogger<AdditionalHourController> logger)
           : base(serviceProvider, logger)
        {
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_ADDITIONAL_HOUR")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
        [HttpPut("update"), Authorize("UPDATE_ADDITIONAL_HOUR")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
    }
}
