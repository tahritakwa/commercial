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
    [Route("api/nature")]
    public class NatureController : BaseController, INatureController
    {
        private readonly IServiceNature _serviceNature;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public NatureController(IServiceProvider serviceProvider, IServiceNature serviceNature, ILogger<NatureController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceNature = serviceNature;
        }
        [HttpGet("getDataDropdown"), Authorize("ADD_ITEM,UPDATE_ITEM,SHOW_WAREHOUSE,LIST_QUICK_SALES,LIST_ITEM,UPDATE_WAREHOUSE,UPDATE_TRANSFER_MOVEMENT,ADD_TRANSFER_MOVEMENT,ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES" +
            "ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT,ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE,ADD_SHELFS_AND_STORAGES,UPDATE_SHELFS_AND_STORAGES,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,COUNTER_SALES")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpGet("getById/{id}"), Authorize("ADD_ITEM,DETAILS_ITEM,UPDATE_ITEM")]
        public override ResponseData GetById(int id)
        {
            return base.GetById(id);
        }
        [HttpPost("getModelByCondition"), Authorize("UPDATE_ITEM,UPDATE_NATURE")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }
        [HttpPost("getPictures"), Authorize("LIST_NATURE")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }
        [HttpPost("getPicture"), Authorize("UPDATE_NATURE,ADD_NATURE,SHOW_NATURE")]
        public override byte[] getPicture([FromBody] string path)
        {
            return base.getPicture(path);
        }
        }

}
