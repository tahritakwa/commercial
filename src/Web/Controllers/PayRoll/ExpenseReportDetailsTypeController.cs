using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;
using Web.Controllers.Shared.Classes;

namespace Web.Controllers.PayRoll
{
    [Route("api/expenseReportDetailsType")]
    public class ExpenseReportDetailsTypeController : BaseController
    {
        public ExpenseReportDetailsTypeController(IServiceProvider serviceProvider, ILogger<CurrencyController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_EXPENSEREPORT,UPDATE_EXPENSEREPORT")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }

    }
}
