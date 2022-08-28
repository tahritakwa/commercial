using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/loanInstallment")]
    public class LoanInstallmentController : BaseController
    {
        public LoanInstallmentController(IServiceProvider serviceProvider,
            ILogger<LoanInstallmentController> logger)
            : base(serviceProvider, logger)
        {
            _logger = logger;

        }
        [HttpPost("getDataSourcePredicate"), Authorize("SHOW_LOAN")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
