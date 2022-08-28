using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/trainingCenterRoom")]
    public class TrainingCenterRoomController : BaseController
    {
        public TrainingCenterRoomController(IServiceProvider serviceProvider, ILogger<TrainingCenterRoomController> logger)
           : base(serviceProvider, logger)
        {
            _logger = logger;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("ADD_CENTER,ADD_TRAININGSESSION,UPDATE_TRAININGSESSION,SHOW_TRAINING_SESSION")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
