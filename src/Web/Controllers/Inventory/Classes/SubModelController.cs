using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Inventory.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/subModel")]
    public class SubModelController : BaseController, ISubModelController
    {
        private readonly IServiceSubModel _serviceSubModel;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public SubModelController(IServiceProvider serviceProvider, IServiceSubModel serviceSubModel, ILogger<SubModelController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceSubModel = serviceSubModel;
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_ITEM,LIST_QUICK_SALES,LIST_PRICES,ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpPost("getSubModelList")]
        public ListObject GetSubModelList([FromBody] PredicateFormatViewModel model)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceSubModel.FindPriceDataSourceModelBy(model);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };

            return result.listObject;
        }
        [HttpPost("getPictures"), Authorize("ADD_SUBMODEL,UPDATE_SUBMODEL,SHOW_SUBMODEL,LIST_SUBMODEL")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }
        [HttpPost("getPicture"), Authorize("ADD_SUBMODEL,UPDATE_SUBMODEL,SHOW_SUBMODEL,LIST_SUBMODEL")]
        public override byte[] getPicture([FromBody] string path)
        {
            return base.getPicture(path);
        }
    }
}
