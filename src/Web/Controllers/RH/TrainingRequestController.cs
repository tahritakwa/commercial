using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
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
    [Route("api/trainingRequest")]
    public class TrainingRequestController : BaseController
    {
        private readonly IServiceTrainingRequest _serviceTrainingRequest;
        public TrainingRequestController(IServiceProvider serviceProvider, ILogger<TrainingRequestController> logger,
            IServiceTrainingRequest serviceTrainingRequest)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceTrainingRequest = serviceTrainingRequest;
        }

        /// <summary>
        /// getEmployeeListNotIncludedInTrainingSession
        /// </summary>
        /// <param name="objectSaved"></param>
        /// <returns></returns>

        [HttpPost, Route("getEmployeeListNotIncludedInTrainingSession"), Authorize("LIST_TRAININGREQUEST,ALL_TRAINING_REQUEST")]
        public ResponseData GetEmployeeListNotIncludedInTrainingSession([FromBody] ObjectToSaveViewModel objectSaved)
        {
            GetUserMail();
            int idTraining = (int)objectSaved.model.idTraining.Value;
            List<int> idEmployeeListInTrainingSession = JsonConvert.DeserializeObject<List<int>>(objectSaved.model.idEmployeesList.ToString());
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _serviceTrainingRequest.GetEmployeeListNotIncludedInTrainingSession(idEmployeeListInTrainingSession, idTraining),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        /// <summary>
        /// Add Selected Employees To TrainingRequest
        /// </summary>
        /// <param name="files"></param>
        /// <param name="objectSaved"></param>
        /// <param name="objectJsonToSave"></param>
        /// <returns></returns>
        [HttpPost("addSelectedEmployeesToTrainingRequest"), Authorize("ADD_TRAININGREQUEST")]
        public ResponseData AddSelectedEmployeesToTrainingRequest([FromBody] ObjectToSaveViewModel objectSaved)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            IList<TrainingRequestViewModel> trainingRequestList = JsonConvert.DeserializeObject<IList<TrainingRequestViewModel>>(objectSaved.model.trainingRequestList.ToString());
            _serviceTrainingRequest.AddSelectedEmployeesToTrainingRequest(userMail, trainingRequestList);
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.flag = 1;
            return result;
        }

        /// <summary>
        /// AddOrUpdateTrainingRequestlWithoutTransaction: save the trainingRequest model
        /// </summary>
        /// <param name="files"></param>
        /// <param name="objectSaved"></param>
        /// <param name="objectJsonToSave"></param>
        /// <returns></returns>
        [HttpPost("addOrUpdateTrainingRequest"), Authorize("ADD_TRAININGREQUEST")]
        public ResponseData AddOrUpdateTrainingRequestlWithoutTransaction(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            bool isNew = objectSaved.model.isNew;
            TrainingRequestViewModel trainingRequest = JsonConvert.DeserializeObject<TrainingRequestViewModel>(objectSaved.model.trainingRequest.ToString());
            if (isNew)
            {
                var obj = _serviceTrainingRequest.AddModelWithoutTransaction(trainingRequest, objectSaved.EntityAxisValues, userMail);
                result.objectData = obj;
            }
            else
            {
                _serviceTrainingRequest.UpdateModelWithoutTransaction(trainingRequest, objectSaved.EntityAxisValues, userMail);
            }
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.flag = 1;
            return result;
        }

        /// <summary>
        /// GetTrainingRequestListByHierarchy
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost, Route("getTrainingRequestListByHierarchy"), Authorize("LIST_TRAININGREQUEST,ALL_TRAINING_REQUEST")]
        public ResponseData GetTrainingRequestListByHierarchy([FromBody] ObjectToSaveViewModel objectToSave)
        {
            GetUserMail();
            PredicateFormatViewModel predicateFormatViewModel = new PredicateFormatViewModel();

            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _serviceTrainingRequest.GetTrainingRequestListByHierarchy(userMail, predicateFormatViewModel),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        /// <summary>
        /// Get training request list which have no training session for planing a new session
        /// </summary>
        /// <param name="idTraining"></param>
        /// <returns></returns>
        [HttpPost, Route("getTrainingRequestListForPanifing"), Authorize("LIST_TRAININGREQUEST,ADD_TRAININGSESSION,UPDATE_TRAININGSESSION")]
        public ResponseData GetTrainingRequestListForPanifing([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int idTraining = (int)objectToSave.model.IdTraining.Value;
            PredicateFormatViewModel predicate = new PredicateFormatViewModel();
            if (objectToSave.model.predicate != null)
            {
                predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _serviceTrainingRequest.GetTrainingRequestListForPanifing(idTraining, predicate),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        /// <summary>
        /// GetTrainingRequestListInUpdateMode
        /// </summary>
        /// <param name="idTraining"></param>
        /// <returns></returns>
        [HttpPost, Route("getTrainingRequestListInUpdateMode"), Authorize("LIST_TRAININGREQUEST,ALL_TRAINING_REQUEST,UPDATE_TRAININGSESSION,SHOW_TRAINING_SESSION")]
        public ResponseData GetTrainingRequestListInUpdateMode([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int idTraining = (int)objectToSave.model.IdTraining.Value;
            int idTrainingSession = (int)objectToSave.model.IdTrainingSession.Value;
            PredicateFormatViewModel predicate = new PredicateFormatViewModel();
            if (objectToSave.model.predicate != null)
            {
                predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _serviceTrainingRequest.GetTrainingRequestListInUpdateMode(idTraining, idTrainingSession, predicate),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }
    }
}
