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

namespace Web.Controllers.RH
{
    [Route("api/externalTrainer")]
    public class ExternalTrainerController : BaseController
    {
        public ExternalTrainerController(IServiceProvider serviceProvider, ILogger<ExternalTrainerController> logger)
            : base(serviceProvider, logger)
        {
            _logger = logger;
        }

        [HttpGet("get"), Authorize("ADD_TRAININGSESSION,UPDATE_TRAININGSESSION,SHOW_TRAINING_SESSION")]
        public override ResponseData Get()
        {
            return base.Get();
        }
        [HttpPost("insert"), Authorize("ADD_TRAINER")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }
        [HttpPost("getModelByCondition"), Authorize("ADD_CENTER,ADD_TRAININGSESSION,UPDATE_TRAININGSESSION,SHOW_TRAINING_SESSION")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }
    }
}
