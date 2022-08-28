using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Persistence.Entities;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/salaryRule")]
    public class SalaryRuleController : BaseController
    {
        private readonly IServiceSalaryRule _serviceSalaryRule;
        private readonly IServiceSalaryStructureValidityPeriodSalaryRule _serviceSalaryStructureValidityPeriodSalaryRule;


        public SalaryRuleController(IServiceProvider serviceProvider, ILogger<SalaryRuleController> logger,
            IServiceSalaryRule serviceSalaryRule, IServiceSalaryStructureValidityPeriodSalaryRule serviceSalaryStructureValidityPeriodSalaryRule)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceSalaryRule = serviceSalaryRule;
            _serviceSalaryStructureValidityPeriodSalaryRule = serviceSalaryStructureValidityPeriodSalaryRule;
        }

        [HttpGet("getSessionResumeColumnOrder"), Authorize("LIST_SALARYRULE")]
        public ResponseData GetSessionResumeColumnOrder()
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceSalaryStructureValidityPeriodSalaryRule.GetSessionResumeColumnOrder(),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpGet("getSalaryRuleOrderedByApplicabilityThenByOrder"), Authorize("ADD_SALARYRULE,SHOW_SALARYRULE,ADD_SALARYSTRUCTURE,SHOW_SALARYSTRUCTURE")]
        public ResponseData GetSalaryRuleOrderedByApplicabilityThenByOrder()
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceSalaryRule.GetSalaryRuleOrderedByApplicabilityThenByOrder(),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("checkIfSalaryRuleIsAssociatedWithAnyPayslip"), Authorize("ADD_SALARYRULE,UPDATE_SALARYRULE")]
        public IList<Payslip> CheckIfSalaryRuleIsAssociatedWithAnyPayslip([FromBody] SalaryRuleViewModel model)
        {
            return _serviceSalaryRule.CheckIfSalaryRuleIsAssociatedWithAnyPayslip(model);
        }
    }
}
