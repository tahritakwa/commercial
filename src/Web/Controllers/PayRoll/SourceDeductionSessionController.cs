using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/sourceDeductionSession")] 
    public class SourceDeductionSessionController : BaseController
    {
        private readonly IServiceSourceDeductionSession _serviceSourceDeductionSession;
        private readonly SmtpSettings _smtpSettings;
        public SourceDeductionSessionController(IServiceProvider serviceProvider, IOptions<SmtpSettings> smtpSettings
            , ILogger<SourceDeductionSessionController> logger, IServiceSourceDeductionSession serviceSourceDeduction)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceSourceDeductionSession = serviceSourceDeduction;
            _smtpSettings = smtpSettings.Value;
        }

        /// <summary>
        /// Specific api for check if the session number is unique per year or not
        /// </summary>
        /// <param name="sourceDeductionSession"></param>
        /// <returns></returns>
        [HttpPost("getUnicitySourceDeductionSession"), Authorize("SHOW_SOURCEDEDUCTIONSESSION")]
        public bool GetUnicitySessionNumberPerYear([FromBody] SourceDeductionSessionViewModel sourceDeductionSession)
        {
            return sourceDeductionSession != null &&
                _serviceSourceDeductionSession.GetUnicitySessionNumberPerYear(sourceDeductionSession);
        }

        [HttpGet("getSourceDeductionSessionDetails/{id}"), Authorize("SHOW_SOURCEDEDUCTIONSESSION")]
        public ResponseData GetSessionDetails(int id)
        {
            ResponseData result = new ResponseData();
            if (id > 0)
            {
                result.flag = 1;
                result.objectData = _serviceSourceDeductionSession.GetSessionDetails(id);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }

        /// <summary>
        /// if there is an open session or wrong source deduction, it will catch
        /// </summary>
        /// <param name="sourceDeductionSession"></param>
        /// <returns></returns>
        [HttpPost("checkSourceDeductionSessionBeforeClosing"), Authorize("CLOSE_SOURCEDEDUCTIONSESSION")]
        public bool CheckSourceDeductionSessionBeforeClosing([FromBody] SourceDeductionSessionViewModel sourceDeductionSession)
        {
            _serviceSourceDeductionSession.CheckSourceDeductionSessionBeforeClosing(sourceDeductionSession);
            return true;
        }

        [HttpPut("closeSourceDeduction"), Authorize("CLOSE_SOURCEDEDUCTIONSESSION")]
        public ResponseData CloseSourceDeduction([FromBody] SourceDeductionSessionViewModel model)
        {
            GetUserMail();
            _serviceSourceDeductionSession.UpdateModel(model, null, userMail);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
    }
}
