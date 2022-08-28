using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.RH.Interfaces;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/trainingSeance")]
    public class TrainingSeanceController : BaseController
    {
        private readonly IServiceTrainingSeance _serviceTrainingSeance;
        public TrainingSeanceController(IServiceProvider serviceProvider, ILogger<TrainingSeanceController> logger,
            IServiceTrainingSeance serviceTrainingSeance)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceTrainingSeance = serviceTrainingSeance;
        }

        /// <summary>
        /// GetTrainingSeanceListInUpdateMode
        /// </summary>
        /// <param name="idTraining"></param>
        /// <returns></returns>
        [HttpGet, Route("getTrainingSeanceListInUpdateMode/{idTrainingSession}"), Authorize("LIST_TRAININGREQUEST,UPDATE_TRAININGSESSION,SHOW_TRAINING_SESSION")]
        public ResponseData GetTrainingSeanceListInUpdateMode(int idTrainingSession)
        {
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _serviceTrainingSeance.GetTrainingSeanceListInUpdateMode(idTrainingSession),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }
    }
}
