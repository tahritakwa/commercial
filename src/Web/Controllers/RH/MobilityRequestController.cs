using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.RH.Interfaces;
using Settings.Exceptions;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.RH;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/mobilityRequest")]
    public class MobilityRequestController : BaseController
    {
        private readonly IServiceMobilityRequest _serviceMobilityRequest;


        public MobilityRequestController(IServiceProvider serviceProvider, ILogger<InterviewController> logger,
            IServiceMobilityRequest serviceMobilityRequest)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceMobilityRequest = serviceMobilityRequest;
        }


        [HttpGet("getById/{id}"), Authorize("LIST_MOBILITYREQUEST")]
        public override ResponseData GetById(int id)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            GetUserMail();

            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceMobilityRequest.GetModelById(id, userMail),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };

            return result;
        }

        [HttpPut("mobilityRequestValidation"), Authorize("UPDATE_MOBILITYREQUEST")]
        public ResponseData MobilityRequestAcceptedByDepartureManager([FromBody] MobilityRequestViewModel model)
        {
            ResponseData result = new ResponseData();
            _serviceMobilityRequest.MobilityRequestValidation(model);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = 1;
            return result;
        }
    }
}