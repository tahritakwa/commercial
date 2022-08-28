using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using System;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/exitEmployee")]
    public class ExitEmployeeController : BaseController
    {
        private readonly IServiceExitEmployee _serviceEmployeeExit;

        private readonly SmtpSettings _smtpSettings;
        public ExitEmployeeController(IServiceProvider serviceProvider,
            ILogger<ExitEmployeeController> logger,
            IOptions<SmtpSettings> smtpSettings,
            IServiceExitEmployee serviceEmployeeExit)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceEmployeeExit = serviceEmployeeExit;
            _smtpSettings = smtpSettings.Value;
        }
        [HttpPost("validate"), Authorize("VALIDATE_EXITEMPLOYEE,REFUSE_EXITEMPLOYEE")]
        public ResponseData ValidateOrCancelRequest([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            else
            {
                ExitEmployeeViewModel employeeExitViewModel = JsonConvert.DeserializeObject<ExitEmployeeViewModel>(objectToSave.model.ToString());
                GetUserMail();
                _serviceEmployeeExit.ValidateExitEmployee(employeeExitViewModel, objectToSave.EntityAxisValues, userMail, _smtpSettings);



                ResponseData result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.SuccessValidation,
                    flag = NumberConstant.One
                };
                return result;
            }
        }
        /// <summary>
        /// choose method according to the idAction
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost, Route("ChooseMethodAccordingToAction"), Authorize("ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE")]
        public ResponseData ChooseMethodAccordingToAction([FromBody] ObjectToSaveViewModel objectToSave)
        {
            int idAction = objectToSave.model.IdExitAction;
            ExitEmployeeViewModel employeeExit = JsonConvert.DeserializeObject<ExitEmployeeViewModel>(objectToSave.model.employeeExit.ToString());
            _serviceEmployeeExit.ChooseMethodAccordingToAction(idAction, employeeExit);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.UpdateSuccessfull
            };
            return result;
        }

        /// <summary>
        /// Validate all exit employee pay lines
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("validateAllExitEmployeePayline/{id}"), Authorize(Roles = "ADD")]
        public ResponseData ValidateAllExitEmployeePayLine(int id)
        {
            _serviceEmployeeExit.ValidateAllExitEmployeePayLine(id);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = NumberConstant.One
            };
            return result;
        }
    }
}

