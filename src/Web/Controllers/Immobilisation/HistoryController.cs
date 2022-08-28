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

namespace Web.Controllers.Immobilisation
{
    [Route("api/history")]
    public class HistoryController : BaseController
    {
        public HistoryController(IServiceProvider serviceProvider, ILogger<HistoryController> logger)
           : base(serviceProvider, logger)
        {
            _logger = logger;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_EMPLOYEE,LIST_ASSIGNMENT_ACTIVE,ADD_ASSIGNMENT_ACTIVE,SHOW_USER")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("insert"), Authorize("ADD_ASSIGNMENT_ACTIVE")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }

        [HttpPut("update"), Authorize("UPDATE_ASSIGNMENT_ACTIVE")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }

        [HttpDelete("delete/{id}"), Authorize("DELETE_ASSIGNMENT_ACTIVE")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }

    }
}
