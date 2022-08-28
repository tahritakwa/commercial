using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Persistence.Entities;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/variable")]
    public class VariableController : BaseController
    {
        private readonly IServiceVariable _serviceVariable;

        public VariableController(IServiceProvider serviceProvider, ILogger<VariableController> logger,
            IServiceVariable serviceVariable)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceVariable = serviceVariable;
        }


        [HttpPost("checkIfVariableIsUsedInAnyRuleUsedinAnyPayslip"), Authorize("ADD_VARIABLE,UPDATE_VARIABLE")]
        public IList<Payslip> CheckIfVariableIsUsedInAnyRuleUsedinAnyPayslip([FromBody] VariableViewModel model)
        {
            return _serviceVariable.CheckIfVariableIsUsedInAnyRuleUsedinAnyPayslip(model);
        }
    }
}
