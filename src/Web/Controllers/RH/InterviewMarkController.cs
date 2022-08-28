using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.RH.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/interviewMark")]
    public class InterviewMarkController : BaseController
    {
        private readonly IServiceInterviewMark _serviceInterviewMark;
        private readonly IServiceUser _serviceUser;


        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        /// <param name="serviceInterviewMark"></param>
        public InterviewMarkController(IServiceProvider serviceProvider, ILogger<InterviewMarkController> logger,
            IServiceInterviewMark serviceInterviewMark, IServiceUser serviceUser)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceInterviewMark = serviceInterviewMark;
            _serviceUser = serviceUser;
        }



        [HttpPost, Route("updateInterviewMarkWithCriteriaMark"), Authorize("UPDATE_INTERVIEWMARK,FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT")]
        public ResponseData UpdateInterviewMarkWithCriteriaMark([FromBody] InterviewMarkViewModel interviewMark)
        {
            ResponseData result = new ResponseData();

            GetUserMail();
            UserViewModel currentUser = _serviceUser.GetModel(user => user.Email == userMail);

            bool hasRole = SpecificAuthorizationCheck.CheckAuthorizationByName(Constants.CONFIRM_INTERVIEW_MARK, Request.HttpContext)
                || SpecificAuthorizationCheck.CheckAuthorizationByName(Constants.FULL_RECRUITMENT, Request.HttpContext);
            if ((!hasRole) && (interviewMark.IdEmployee != currentUser.IdEmployee))
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }

            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                _serviceInterviewMark.UpdateInterviewMarkWithCriteriaMark(interviewMark, userMail);

                result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
                result.flag = 1;
                return result;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="idInterviewMark"></param>
        /// <returns></returns>
        [HttpGet, Route("getInterviewMarkCriteriaMarkList/{id}"), Authorize("LIST_INTERVIEWMARK,FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT")]
        public IList<CriteriaMarkViewModel> GetInterviewMarkCriteriaMarkList(int id)
        {
            return _serviceInterviewMark.GetInterviewMarkCriteriaMarkList(id);

        }

        [HttpPost("getModelByCondition"), Authorize("FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }
    }
}
