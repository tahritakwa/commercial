using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Persistence.Entities;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/bonus")]
    public class BonusController : BaseController
    {
        private readonly IServiceBonus _serviceBonus;
        public BonusController(IServiceProvider serviceProvider,
           ILogger<BonusController> logger, IServiceBonus serviceBonus)
           : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceBonus = serviceBonus;
        }

        [HttpPost("checkIfBonusIsAssociatedWithAnyPayslip"), Authorize("ADD_BONUS,UPDATE_BONUS")]
        public IList<Payslip> CheckIfBonussHasAnyPayslip([FromBody] BonusViewModel model)
        {
            return _serviceBonus.CheckIfBonusIsAssociatedWithAnyPayslip(model);
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_CONTRACT,FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT,ADD_CONTRACT,UPDATE_CONTRACT")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpPost("getDataSourcePredicate"), Authorize("SHOW_PAYROLL_SESSION")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
