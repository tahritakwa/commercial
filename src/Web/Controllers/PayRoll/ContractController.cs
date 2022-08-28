using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Persistence.Entities;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Constants.RHConstants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/contract")]
    public class ContractController : BaseController
    {
        private readonly IServiceContract _serviceContract;
        public ContractController(IServiceProvider serviceProvider, IOptions<SmtpSettings> smtpSettings
           , ILogger<ContractController> logger, IServiceContract serviceContract)
           : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceContract = serviceContract;
        }

        /// <summary>
        /// Check if there are payslips or timesheets to update and notify user before update
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("checkBeforeUpdateIfContractsHaveAnyPayslipOrTimesheet"), Authorize("UPDATE_CONTRACT")]
        public ObjectToSaveViewModel CheckBeforeUpdateIfContractsHaveAnyPayslipOrTimesheet([FromBody] ObjectToSaveViewModel objectToSave)
        {
            IList<Contract> listContracts = JsonConvert.DeserializeObject<IList<Contract>>(objectToSave.model.Contracts.ToString());
            bool isFromContract = (bool)objectToSave.model.IsFromContract.Value;
            return _serviceContract.CheckBeforeUpdateIfContractsHaveAnyPayslipOrTimesheet(listContracts, isFromContract);
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_CONTRACT")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            if (!RoleHelper.HasPermission(RHPermissionConstant.LIST_RESIGNED_EMPLOYEES))
            {
                model.Filter.Add(new FilterViewModel
                {
                    Prop = nameof(Contract.IdEmployeeNavigation) + GenericConstants.Point + nameof(Contract.IdEmployeeNavigation.Status),
                    Operation = Operation.NotEquals,
                    Value = (int)EmployeeState.Resigned
                });
            }
            return base.GetDataSourcePredicate(model);
        }

        [HttpGet("getById/{id}"), Authorize("SHOW_CONTRACT")]
        public override ResponseData GetById(int id)
        {
            return base.GetById(id);
        }

    }
}
