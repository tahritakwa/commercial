using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.ErpSettings.Interfaces;
using Settings.Config;
using System;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.ErpSettings.Interfaces;
using Web.Controllers.GenericController;

namespace Web.Controllers.ErpSettings.Classes
{
    [Route("api/Mail")]
    public class MailingController : BaseController, IMailingController
    {
        private readonly IServiceMessage _msgService;
        private readonly SmtpSettings _smtpSettings;
        public MailingController(IServiceMessage msgService, IOptions<SmtpSettings> smtpSettings, IServiceProvider serviceProvider, ILogger<MailingController> logger) : base(serviceProvider, logger)
        {
            _msgService = msgService;
            _smtpSettings = smtpSettings.Value;
        }

        [HttpPost("send"), AllowAnonymous]
        public void BroadCastMail([FromBody] MailBrodcastConfigurationViewModel configModel)
        {
            _msgService.ConfigureMail(configModel, _smtpSettings);
        }
    }
}
