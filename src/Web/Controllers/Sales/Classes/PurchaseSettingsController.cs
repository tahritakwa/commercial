using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Sales.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/purchaseSettings")]
    public class PurchaseSettingsController : BaseController
    {
        private readonly IServicePurchaseSettings _servicePurchaseSettings;
        public PurchaseSettingsController(IServiceProvider serviceProvider, ILogger<PurchaseSettingsController> logger, IServicePurchaseSettings servicePurchaseSettings)
          : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _servicePurchaseSettings = servicePurchaseSettings;
        }
        [HttpGet("get"), Authorize("ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE,UPDATE_EXIT_VOUCHERS,ADD_EXIT_VOUCHERS," +
            "SHOW_RECEIPT_PURCHASE,SHOW_INVOICE_PURCHASE")]
        public override ResponseData Get()
        {
            return base.Get();
        }


    }
}
