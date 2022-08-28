using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Administration.Interfaces;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Shared;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/period")]
    public class PeriodController : BaseController
    {
        private readonly IServicePeriod _servicePeriod;
        public PeriodController(IServiceProvider serviceProvider, ILogger<BaseController> logger, IServicePeriod servicePeriod)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _servicePeriod = servicePeriod;
        }

        [HttpPost("getHoursPeriodOfDate"), Authorize("LIST_PERIOD,ADD_LEAVEREQUEST"),
            Authorize("UPDATE_LEAVEREQUEST")]
        public ResponseData GetHoursPeriodOfDate([FromBody] DateTime date)
        {
            ResponseData result = new ResponseData
            {
                objectData = _servicePeriod.GetHoursPeriodOfDate(date),
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("checkIfDayOffsUpdateCorruptedPayslipOrTimesheet"), Authorize("LIST_PERIOD")]
        public ObjectToSaveViewModel CheckIfDayOffsUpdateCorruptedPayslipOrTimesheet([FromBody] PeriodViewModel model)
        {
            return _servicePeriod.CheckIfDayOffsUpdateCorruptedPayslipOrTimesheet(model);
        }
        [HttpPost("insert"), Authorize("ADD_PERIOD")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }
        [HttpPost("update"), Authorize("UPDATE_PERIOD")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
    }
}
