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
    [Route("api/detailsSettlementMode")]
    public class DetailsSettlementModeController : BaseController
    {
        private readonly IServiceDetailsSettlementMode _serviceDetailsSettlementMode;
        public DetailsSettlementModeController(IServiceProvider serviceProvider, ILogger<DetailsSettlementModeController> logger, IServiceDetailsSettlementMode serviceDetailsSettlementMode)
          : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _serviceDetailsSettlementMode = serviceDetailsSettlementMode;
        }
        [HttpPost("getDataSourcePredicate"), Authorize("UPDATE_SETTLEMENTMODE,SHOW_SETTLEMENTMODE,ADD_SETTLEMENTMODE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }


    }
}
