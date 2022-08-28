using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/exitActionEmployee")]
    public class ActionsExitEmployeeController : BaseController
    {
        private readonly IServiceExitActionEmployee _serviceExitActionEmployee;

        private readonly SmtpSettings _smtpSettings;
        public ActionsExitEmployeeController(IServiceProvider serviceProvider,
          ILogger<ActionsExitEmployeeController> logger,
          IOptions<SmtpSettings> smtpSettings,
          IServiceExitActionEmployee serviceExitActionEmployee)
          : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceExitActionEmployee = serviceExitActionEmployee;
            _smtpSettings = smtpSettings.Value;
        }

        /// <summary>
        /// get information of exit action employee
        /// </summary>
        /// <param name="exitActionEmployeeViewModel"></param>
        [HttpPost, Route("getExitActionsEmployee"), Authorize("LIST_EXITEMPLOYEEACTIONS,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE")]
        public ResponseData GetExitActionsEmployee([FromBody] ExitActionEmployeeViewModel exitActionEmployeeViewModel)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceExitActionEmployee.GetExitActionEmployeeInformation(exitActionEmployeeViewModel),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_EXITEMPLOYEEACTIONS,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);

        }
    }
}
