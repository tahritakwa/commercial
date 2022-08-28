using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace SparkIt.Web.Controllers.Inventory.Classes
{
    [Route("api/oemItem")]
    public class OemItemController : BaseController
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        /// <param name="logger"></param>
        public OemItemController(IServiceProvider serviceProvider, ILogger<OemItemController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
        }

        [HttpPost("getDataWithSpecificFilter"), Authorize("LIST_ITEM,LIST_OEM")]
        public override ResponseData GetDataWithSpecificFilter([FromBody] List<PredicateFormatViewModel> model)
        {
            return base.GetDataWithSpecificFilter(model);
        }
    }
}
