using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Inventory.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/productItem")]
    public class ProductItemController : BaseController, IProductItemController
    {
        private readonly IServiceProductItem _serviceProductItem;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public ProductItemController(IServiceProvider serviceProvider, IServiceProductItem serviceProductItem, ILogger<ProductItemController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceProductItem = serviceProductItem;
        }
        [HttpGet("getDataDropdown"), Authorize("LIST_ITEM,LIST_TRANSFER_MOVEMENT,LIST_SHELFS_AND_STORAGES,LIST_QUICK_SALES,LIST_PRICES,SHOW_WAREHOUSE,UPDATE_TRANSFER_MOVEMENT,ADD_TRANSFER_MOVEMENT," +
            "ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES" +
            "ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpPost("getPictures"), Authorize("ADD_PRODUCTITEM,SHOW_PRODUCTITEM,UPDATE_PRODUCTITEM,LIST_PRODUCTITEM")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }
        [HttpPost("getPicture"), Authorize("ADD_PRODUCTITEM,SHOW_PRODUCTITEM,UPDATE_PRODUCTITEM,LIST_PRODUCTITEM,SHOW_MODELOFITEM")]
        public override byte[] getPicture([FromBody] string paths)
        {
            return base.getPicture(paths);
        }
    }
}
