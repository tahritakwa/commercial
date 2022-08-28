using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Inventory.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/measureUnit")]
    public class MeasureUnitController : BaseController, IMeasureUnitController
    {
        private readonly IServiceMeasureUnit _serviceMeasureUnit;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public MeasureUnitController(IServiceProvider serviceProvider, IServiceMeasureUnit serviceMeasureUnit, ILogger<MeasureUnitController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceMeasureUnit = serviceMeasureUnit;
        }
        [HttpGet("getDataDropdown"), Authorize("LIST_ITEM,DETAILS_ITEM")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpGet("get"), Authorize("DETAILS_ITEM,ADD_ITEM,LIST_FINANCIAL_ASSET_SALES,UPDATE_ITEM")]
        public override ResponseData Get()
        {
            return base.Get();
        }
        [HttpGet("getById/{id}"), Authorize("LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES,ADD_DELIVERY_SALES," +
            "LIST_FINANCIAL_ASSET_SALES,UPDATE_PRICEREQUEST,ADD_ORDER_QUOTATION_PURCHASE,ADD_FINAL_ORDER_PURCHASE,ADD_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE," +
            "UPDATE_FINAL_ORDER_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,UPDATE_EXIT_VOUCHERS," +
            "UPDATE_VALID_ADMISSION_VOUCHERS,UPDATE_VALID_EXIT_VOUCHERS,UPDATE_MEASUREUNIT,SHOW_MEASUREUNIT,ADD_QUOTATION_SALES,UPDATE_QUOTATION_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,ADD_ORDER_SALES,UPDATE_ORDER_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ASSET_SALES,ADD_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES," +
            "ADD_INVOICE_SALES,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,COUNTER_SALES")]
        public override ResponseData GetById(int id)
        {
            return base.GetById(id);
        }

        [HttpPost("insert"), Authorize("ADD_ITEM,UPDATE_ITEM")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }
    }
}
