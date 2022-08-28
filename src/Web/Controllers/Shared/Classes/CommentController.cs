using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/comment")]
    public class CommentController : BaseController
    {
        public CommentController(IServiceProvider serviceProvider, ILogger<CommentController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpPost("insert"), Authorize("UPDATE_RECRUITMENTREQUEST,UPDATE_PURCHASE_REQUEST,ADD_PURCHASE_REQUEST,UPDATE_EXITEMPLOYEE")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }

        [HttpPut("update"), Authorize("ADD_RECRUITMENTREQUEST,UPDATE_RECRUITMENTREQUEST,FULL_RECRUITMENT,UPDATE_EXITEMPLOYEE,UPDATE_PURCHASE_REQUEST")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }

        [HttpDelete("delete/{id}"), Authorize("ADD_RECRUITMENTREQUEST,UPDATE_RECRUITMENTREQUEST,FULL_RECRUITMENT,UPDATE_EXITEMPLOYEE,UPDATE_PURCHASE_REQUEST")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
