using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Sales.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/expense")]
    public class ExpenseController : BaseController
    {
        private readonly IServiceExpense _serviceExpense;
        public ExpenseController(IServiceProvider serviceProvider, ILogger<ExpenseController> logger, IServiceExpense serviceExpense)
          : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _serviceExpense = serviceExpense;
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }


    }
}
