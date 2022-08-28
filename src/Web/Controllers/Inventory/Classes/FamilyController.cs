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
    [Route("api/family")]
    public class FamilyController : BaseController, IFamilyController
    {
        private readonly IServiceFamily _serviceFamily;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public FamilyController(IServiceProvider serviceProvider, IServiceFamily serviceFamily, ILogger<FamilyController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceFamily = serviceFamily;
        }
        [HttpGet("getDataDropdown"), Authorize("LIST_ITEM,ADD_SUBFAMILY,SHOW_SUBFAMILY,UPDATE_SUBFAMILY,LIST_TRANSFER_MOVEMENT,LIST_SHELFS_AND_STORAGES,LIST_QUICK_SALES,LIST_PRICES,SHOW_WAREHOUSE,UPDATE_WAREHOUSE," +
            "ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES" +
            "ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT,ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,COUNTER_SALES")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }

        [HttpPost("getPictures"), Authorize("SHOW_FAMILY,ADD_FAMILY,UPDATE_FAMILY,LIST_FAMILY,ADD_SUBFAMILY,UPDATE_SUBFAMILY,SHOW_SUBFAMILY,LIST_ITEM,LIST_QUICK_SALES," +
           "ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
           "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
           "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
           "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,SHOW_SUBFAMILY" +
           "ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT, UPDATE_CLAIM_PURCHASE, UPDATE_CLAIM_PURCHASE,UPDATE_ITEM,DETAILS_ITEM,"+
            "ADD_SHELFS_AND_STORAGES,UPDATE_SHELFS_AND_STORAGES,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,COUNTER_SALES")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }
        [HttpPost("getPicture"), Authorize("SHOW_FAMILY,ADD_FAMILY,UPDATE_FAMILY,ADD_SUBFAMILY,UPDATE_SUBFAMILY,SHOW_SUBFAMILY")]
        public override byte[] getPicture([FromBody] string path)
        {
            return base.getPicture(path);
        }
        [HttpDelete("delete/{id}"), Authorize("DELETE_FAMILY,LIST_FAMILY")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
