using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/interview")]
    public class InterviewController : BaseController
    {
        private readonly IServiceInterview _serviceInterview;
        private readonly IServiceUser _serviceUser;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        /// <param name="serviceInterview"></param>
        public InterviewController(IServiceProvider serviceProvider, ILogger<InterviewController> logger,
            IServiceInterview serviceInterview, IServiceUser serviceUser)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceInterview = serviceInterview;
            _serviceUser = serviceUser;
        }


        /// <summary>
        /// confirm the availability for the interview
        /// </summary>
        /// <param name="interview"></param>
        /// <returns></returns>
        [HttpPost, Route("generateInterviewEmailById/{lang}"), Authorize("UPDATE_INTERVIEW,FULL_RECRUITMENT,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE")]
        public ResponseData GenerateInterviewEmailById([FromBody] InterviewViewModel interview, string lang)
        {
            ResponseData result = new ResponseData();

            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }

            result.objectData = _serviceInterview.GenerateInterviewEmailById(interview, lang);

            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            result.flag = NumberConstant.One;
            return result;
        }
        /// <summary>
        /// make The Interview As Requested To Candidate
        /// </summary>
        /// <param name="interview"></param>
        /// <returns></returns>
        [HttpPost, Route("makeTheInterviewAsRequestedToCandidate"), Authorize("UPDATE_INTERVIEW,FULL_RECRUITMENT,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE")]
        public ResponseData MakeTheInterviewAsRequestedToCandidate([FromBody] InterviewViewModel interview)
        {
            ResponseData result = new ResponseData();

            GetUserMail();

            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }

            _serviceInterview.MakeTheInterviewAsRequestedToCandidate(interview, userMail);

            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            result.flag = NumberConstant.One;
            return result;
        }
        /// <summary>
        /// confirm The Candidate Disponibility
        /// </summary>
        /// <param name="interview"></param>
        /// <returns></returns>
        [HttpPost, Route("confirmTheCandidateDisponibility"), Authorize("UPDATE_INTERVIEW,FULL_RECRUITMENT,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE")]
        public ResponseData ConfirmTheCandidateDisponibility([FromBody] InterviewViewModel interview)
        {
            ResponseData result = new ResponseData();

            GetUserMail();

            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }

            _serviceInterview.ConfirmTheCandidateDisponibility(interview);

            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = NumberConstant.One;
            return result;
        }

        [HttpPost("fromInterviewToNextStep"), Authorize("LIST_INTERVIEW,FULL_RECRUITMENT")]
        public ResponseData FromInterviewToNextStep([FromBody] int recruitmentId)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceInterview.FromInterviewToNextStep(recruitmentId);
            result.listObject = new ListObject
            {
                listData = dataSourceResult,
                total = dataSourceResult.Count,
            };
            result.flag = NumberConstant.Two;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

            return result;
        }

        [HttpGet("fromEvaluationToNextStep/{id}"), Authorize("LIST_INTERVIEW,FULL_RECRUITMENT")]
        public ResponseData FromEvaluationToNextStep(int id)
        {
            ResponseData result = new ResponseData();

            var dataSourceResult = _serviceInterview.FromEvaluationToNextStep(id);
            result.listObject = new ListObject
            {
                listData = dataSourceResult,
                total = dataSourceResult.Count
            };
            if (dataSourceResult.Count > NumberConstant.Zero)
            {
                result.flag = NumberConstant.Two;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            else
            {
                result.flag = NumberConstant.Two;
                result.customStatusCode = CustomStatusCode.EmptyEvaluationListViolation;
            }

            return result;

        }

        /// <summary>
        /// GetCandidacyInterviewDetails in selection step
        /// </summary>
        /// <param name="idCandidacy"></param>
        /// <returns></returns>
        [HttpGet("getCandidacyInterviewDetails/{idCandidacy}"), Authorize("LIST_INTERVIEW,FULL_RECRUITMENT")]
        public List<InterviewViewModel> GetCandidacyInterviewDetails(int idCandidacy)
        {
            return _serviceInterview.GetCandidacyInterviewDetails(idCandidacy);
        }

        [HttpPost("cancelInterview"), Authorize("CANCEL_INTERVIEW_PERMISSION")]
        public ResponseData CancelInterview([FromBody] InterviewViewModel interview)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            _serviceInterview.CancelInterview(interview, userMail);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = NumberConstant.One;
            return result;
        }

        /// <summary>
        /// Resend email to interview to confirm availability
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost, Route("resendEmailToInterviewer"), Authorize("REMIND_INTERVIEWER_PERMISSION")]
        public ResponseData ResendEmailToInterviewer([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            ResponseData result = new ResponseData();
            GetUserMail();
            InterviewViewModel interview = JsonConvert.DeserializeObject<InterviewViewModel>(objectToSave.model.interview.ToString());
            int idInterviewer = (int)objectToSave.model.idInterviewer.Value;
            _serviceInterview.ResendEmailToInterviewer(interview, idInterviewer, userMail);
            result.customStatusCode = CustomStatusCode.GetSuccessfull;
            result.flag = NumberConstant.One;
            return result;
        }

        /// <summary>
        /// confirm the availability for the interview
        /// </summary>
        /// <param name="interviewMark"></param>
        /// <returns></returns>
        [HttpPost, Route("confirmAvailabilityForTheInterview"), Authorize("FULL_RECRUITMENT,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE,SHOW_INTERVIEW")]
        public ResponseData ConfirmAvailabilityForTheInterview([FromBody] InterviewMarkViewModel interviewMark)
        {
            ResponseData result = new ResponseData();

            GetUserMail();
            UserViewModel currentUser = _serviceUser.GetModel(user => user.Email == userMail);
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                _serviceInterview.ConfirmAvailabilityForTheInterview(interviewMark, userMail);
                result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
                result.flag = 1;
                return result;
            }
        }

        /// <summary>
        /// Check if there is an overlap of interviews for the same interviewer
        /// </summary>
        /// <param name="interview"></param>
        /// <returns></returns>
        [HttpPost, Route("checkInterviewHasAnotherInterview"), Authorize("FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE,ADD_INTERVIEW,UPDATE_INTERVIEW,DELAY_INTERVIEW_PERMISSION")]
        public bool CheckInterviewHasAnotherInterview([FromBody] InterviewViewModel interview)
        {
            return _serviceInterview.CheckInterviewerHasAnotherInterview(interview);
        }

        [HttpPost("getDataSourcePredicate"), Authorize("FULL_RECRUITMENT,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE,UPDATE_ANNUALINTERVIEW,LIST_ANNUALINTERVIEW,ADD_INTERVIEW")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("insert"), Authorize("FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE,ADD_INTERVIEW")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }

        [HttpPut("update"), Authorize("FULL_RECRUITMENT,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE,DELAY_INTERVIEW_PERMISSION")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }

    }
}
