using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Sales.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/saleSettings")]
    public class SaleSettingsController : BaseController
    {
        private readonly IServiceSaleSettings _serviceSaleSettings;
        public SaleSettingsController(IServiceProvider serviceProvider, ILogger<SaleSettingsController> logger, IServiceSaleSettings serviceSaleSettings)
          : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _serviceSaleSettings = serviceSaleSettings;
        }
        [HttpGet("get"), Authorize("LIST_INVOICE_SALES")]
        public override ResponseData Get()
        {
            return base.Get();
        }


    }
}
