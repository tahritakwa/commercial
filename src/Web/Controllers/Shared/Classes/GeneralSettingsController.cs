using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Shared;
using Web.Controllers.GenericController;
using Web.Controllers.Shared.Interfaces;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/generalSettings")]
  
    public class GeneralSettingsController : BaseController, IGeneralSettingsController
    {
        private readonly IServiceGeneralSettings _serviceGeneralSettings;

        public GeneralSettingsController(IServiceProvider serviceProvider, ILogger<GeneralSettingsController> logger, IServiceGeneralSettings serviceGeneralSettings)
            : base(serviceProvider, logger)
        {
            _serviceGeneralSettings = serviceGeneralSettings;
        }

        [HttpGet("getReviewManagerSettings"), Authorize("SHOW_GENERALSETTINGS")]
        public ResponseData GetReviewManagerSettings()
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceGeneralSettings.GetReviewManagerSettings(),
                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        [HttpPut("UpdateReviewManagerSettings"), Authorize("UPDATE_GENERALSETTINGS")]
        public ResponseData UpdateReviewManagerSettings([FromBody] List<GeneralSettingsViewModel> models)
        {
            ResponseData result = new ResponseData();

            GetUserMail();
            var obj = _serviceGeneralSettings.updateReviewManagerSettings(models, userMail);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.objectData = obj;
            result.flag = 1;

            return result;
        }
    }
}