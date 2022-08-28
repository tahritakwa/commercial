using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/trainingCenter")]
    public class TrainingCenterController : BaseController
    {
        public TrainingCenterController(IServiceProvider serviceProvider, ILogger<TrainingCenterController> logger)
           : base(serviceProvider, logger)
        {
            _logger = logger;
        }

        [HttpGet("get"), Authorize("ADD_TRAININGSESSION,UPDATE_TRAININGSESSION,SHOW_TRAINING_SESSION,ADD_CENTER")]
        public override ResponseData Get()
        {
            return base.Get();
        }
        [HttpPost("insert"), Authorize("ADD_CENTER")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }
    }
}
