using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Inventory.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/movementHistory")]
    public class MovementHistoryController : BaseController
    {
        private readonly IServiceMovementHistory _serviceMovementHistory;
        public MovementHistoryController(IServiceProvider serviceProvider, ILogger<MovementHistoryController> logger,
            IServiceMovementHistory serviceMovementHistory) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceMovementHistory = serviceMovementHistory;
        }
        [HttpPost("getDataSourcePredicate"), Authorize("DETAILS_ITEM,LIST_WAREHOUSE,LIST_QUICK_SALES,HISTORY_ITEM,ADD_PROVISIONING,UPDATE_PROVISIONING")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
