using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Inventory.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/subFamily")]
    public class SubFamilyController : BaseController, ISubFamilyController
    {
        private readonly IServiceSubFamily _serviceSubFamily;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public SubFamilyController(IServiceProvider serviceProvider, IServiceSubFamily serviceSubFamily, ILogger<SubFamilyController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceSubFamily = serviceSubFamily;
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_ITEM,UPDATE_ITEM,LIST_TRANSFER_MOVEMENT,LIST_SHELFS_AND_STORAGES,LIST_QUICK_SALES,LIST_PRICES," +
            "ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpPost("getPictures"), Authorize("ADD_SUBFAMILY,UPDATE_SUBFAMILY,SHOW_SUBFAMILY,LIST_SUBFAMILY")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }
    }
}
