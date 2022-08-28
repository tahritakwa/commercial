using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.RH.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/trainingSession")]
    public class TrainingSessionController : BaseController
    {
        private readonly IServiceTrainingSession _serviceTrainingSession;
        public TrainingSessionController(IServiceProvider serviceProvider, ILogger<TrainingSessionController> logger,
            IServiceTrainingSession serviceTrainingSession)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceTrainingSession = serviceTrainingSession;
        }

        [HttpPost, Route("getTrainingSessionList"), Authorize("LIST_TRAININGREQUEST,LIST_TRAININGSESSION")]
        public ResponseData GetTrainingSessionList([FromBody] PredicateFormatViewModel predicate)
        {
            GetUserMail();
            if (predicate == null)
            {
                predicate = new PredicateFormatViewModel();
            }
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _serviceTrainingSession.GetTrainingSessionList(predicate),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// add training requests with training session
        /// </summary>
        /// <param name="objectSaved"></param>
        /// <returns></returns>
        [HttpPost("addTrainingRequestsWithTrainingSession"), Authorize("ADD_TRAININGREQUEST,ADD_TRAININGSESSION,UPDATE_TRAININGSESSION")]
        public ResponseData AddTrainingRequestToTrainingSession([FromBody] ObjectToSaveViewModel objectSaved)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            IList<TrainingRequestViewModel> trainingRequests = JsonConvert.DeserializeObject<IList<TrainingRequestViewModel>>(objectSaved.model.trainingRequestList.ToString());
            int idTraining = (int)objectSaved.model.IdTraining.Value;
            _serviceTrainingSession.AddTrainingRequestToTrainingSession(userMail, idTraining, trainingRequests);
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.flag = 1;
            return result;
        }

        /// <summary>
        ///  Update training requests with training session
        /// </summary>
        /// <param name="objectSaved"></param>
        /// <returns></returns>
        [HttpPost("updateTrainingRequestsWithTrainingSession"), Authorize("ADD_TRAININGREQUEST,ADD_TRAININGSESSION,UPDATE_TRAININGSESSION")]
        public ResponseData UpdateTrainingRequestsWithTrainingSession([FromBody] ObjectToSaveViewModel objectSaved)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            int idTrainingSession = (int)objectSaved.model.IdTrainingSession.Value;
            IEnumerable<TrainingRequestViewModel> newTrainingRequestSelectedList = JsonConvert.DeserializeObject<IEnumerable<TrainingRequestViewModel>>(objectSaved.model.newTrainingRequestSelectedList.ToString());
            IEnumerable<TrainingRequestViewModel> trainingRequestSelectedToUnSelectedList = JsonConvert.DeserializeObject<IEnumerable<TrainingRequestViewModel>>(objectSaved.model.trainingRequestSelectedToUnSelectedList.ToString());
            _serviceTrainingSession.UpdateTrainingRequestToTrainingSession(userMail, idTrainingSession, newTrainingRequestSelectedList, trainingRequestSelectedToUnSelectedList);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = 1;
            return result;
        }

        /// <summary>
        /// Add training seances with training session
        /// </summary>
        /// <param name="objectSaved"></param>
        /// <returns></returns>
        [HttpPost("addTrainingSeancesWithTrainingSession"), Authorize("ADD_TRAININGREQUEST,ADD_TRAININGSESSION,UPDATE_TRAININGSESSION")]
        public ResponseData AddTrainingSeancesWithTrainingSession([FromBody] ObjectToSaveViewModel objectSaved)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            IList<TrainingSeanceViewModel> traningSeancesPerDate = JsonConvert.DeserializeObject<IList<TrainingSeanceViewModel>>(objectSaved.model.TraningSeancesPerDate.ToString());
            IList<TrainingSeanceDayViewModel> trainingSeancesFrequently = JsonConvert.DeserializeObject<IList<TrainingSeanceDayViewModel>>(objectSaved.model.TrainingSeancesFrequently.ToString());
            int idTraining = (int)objectSaved.model.IdTraining.Value;
            _serviceTrainingSession.AddTrainingSeancesWithTrainingSession(userMail, idTraining, traningSeancesPerDate, trainingSeancesFrequently);
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.flag = 1;
            return result;
        }

        /// <summary>
        /// Update training seances with training session
        /// </summary>
        /// <param name="objectSaved"></param>
        /// <returns></returns>
        [HttpPost("updateTrainingSeancesWithTrainingSession"), Authorize("ADD_TRAININGREQUEST,ADD_TRAININGSESSION,UPDATE_TRAININGSESSION")]
        public ResponseData UpdateTrainingSeancesWithTrainingSession([FromBody] ObjectToSaveViewModel objectSaved)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            IList<TrainingSeanceViewModel> traningSeancesPerDate = JsonConvert.DeserializeObject<IList<TrainingSeanceViewModel>>(objectSaved.model.TraningSeancesPerDate.ToString());
            IList<TrainingSeanceDayViewModel> trainingSeancesFrequently = JsonConvert.DeserializeObject<IList<TrainingSeanceDayViewModel>>(objectSaved.model.TrainingSeancesFrequently.ToString());
            TrainingSessionViewModel trainingSession = JsonConvert.DeserializeObject<TrainingSessionViewModel>(objectSaved.model.trainingSession.ToString());
            _serviceTrainingSession.UpdateTrainingSeancesWithTrainingSession(userMail, trainingSession, traningSeancesPerDate, trainingSeancesFrequently);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = 1;
            return result;
        }
        /// <summary>
        /// addExternalTrainingWithTrainingSession
        /// </summary>
        /// <param name="objectSaved"></param>
        /// <returns></returns>
        [HttpPost("addExternalTrainingWithTrainingSession"), Authorize("ADD_TRAININGREQUEST,ADD_TRAININGSESSION,UPDATE_TRAININGSESSION")]
        public ResponseData AddExternalTrainingWithTrainingSession([FromBody] ObjectToSaveViewModel objectSaved)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            TrainingSessionViewModel trainingSession = JsonConvert.DeserializeObject<TrainingSessionViewModel>(objectSaved.model.trainingSession.ToString());
            int idRoom = (int)objectSaved.model.idRoom.Value;
            List<int> idSelectedEmployee = JsonConvert.DeserializeObject<List<int>>(objectSaved.model.idSelectedEmployee.ToString());
            _serviceTrainingSession.AddExternalTrainingWithTrainingSession(userMail, trainingSession, idRoom, idSelectedEmployee);
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.flag = 1;
            return result;
        }
        /// <summary>
        /// updateExternalTrainingWithTrainingSession
        /// </summary>
        /// <param name="objectSaved"></param>
        /// <returns></returns>
        [HttpPost("updateExternalTrainingWithTrainingSession"), Authorize("ADD_TRAININGREQUEST,ADD_TRAININGSESSION,UPDATE_TRAININGSESSION")]
        public ResponseData UpdateExternalTrainingWithTrainingSession([FromBody] ObjectToSaveViewModel objectSaved)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            TrainingSessionViewModel trainingSession = JsonConvert.DeserializeObject<TrainingSessionViewModel>(objectSaved.model.trainingSession.ToString());
            ExternalTrainingViewModel externalTraining = JsonConvert.DeserializeObject<ExternalTrainingViewModel>(objectSaved.model.externalTraining.ToString());
            int idRoom = (int)objectSaved.model.idRoom.Value;
            List<int> idSelectedEmployee = JsonConvert.DeserializeObject<List<int>>(objectSaved.model.idSelectedEmployee.ToString());
            _serviceTrainingSession.UpdateExternalTrainingWithTrainingSession(userMail, trainingSession, idRoom, externalTraining, idSelectedEmployee);
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.flag = 1;
            return result;
        }
        [HttpPost("getModelByCondition"), Authorize("ADD_TRAININGSESSION,UPDATE_TRAININGSESSION,SHOW_TRAINING_SESSION")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }
    }
}
