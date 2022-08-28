using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Shared;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared
{
    [Route("api/Email")]
    public class EmailController : BaseController
    {
        private readonly IServiceEmail _serviceEmail;
        private readonly SmtpSettings _smtpSettings;
        public EmailController(IServiceEmail serviceEmail, IOptions<SmtpSettings> smtpSettings, IServiceProvider serviceProvider, ILogger<EmailController> logger) : base(serviceProvider, logger)
        {
            if (smtpSettings == null)
            {
                throw new ArgumentException("");
            }
            _serviceEmail = serviceEmail;
            _smtpSettings = smtpSettings.Value;
        }
        /// <summary>
        /// Send Email
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        [HttpPost, Route("sendEmail"), AllowAnonymous]
        public ResponseData SendEmail([FromBody] EmailViewModel email)
        {
            if (email == null)
            {
                throw new ArgumentException("");
            }

            ResponseData result = new ResponseData();

            GetUserMail();

            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }

            bool hasRole = string.Compare(userMail.ToUpper(CultureInfo.InvariantCulture),
                email.Sender.ToUpper(CultureInfo.InvariantCulture),
                false, CultureInfo.CurrentCulture) == 0;
            hasRole = hasRole || SpecificAuthorizationCheck.CheckAuthorizationByName(Constants.FULL_RECRUITMENT, Request.HttpContext);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }

            email.AttemptsToSendNumber += 1;
            _serviceEmail.UpdateModel(email, null, userMail);

            _serviceEmail.PrepareAndSendEmail(email, userMail, _smtpSettings);

            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = 1;
            return result;
        }

        [HttpPut("update"), Authorize("FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT,ADD_EMPLOYEEEXIT,UPDATE_EMPLOYEEEXIT")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
    }
}
