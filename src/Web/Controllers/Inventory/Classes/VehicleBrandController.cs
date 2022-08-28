using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Inventory.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/vehicleBrand")]
    public class VehicleBrandController : BaseController, IVehicleBrandController
    {
        private readonly IServiceVehicleBrand _serviceVehicleBrand;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public VehicleBrandController(IServiceProvider serviceProvider, IServiceVehicleBrand serviceVehicleBrand, ILogger<VehicleBrandController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceVehicleBrand = serviceVehicleBrand;
        }
        [HttpGet("getDataDropdown"), Authorize("ADD_MODELOFITEM,UPDATE_MODELOFITEM,LIST_ITEM,LIST_QUICK_SALES,LIST_PRICES")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_WAREHOUSE,SHOW_WAREHOUSE,LIST_QUICK_SALES,LIST_ITEM,SHOW_VEHICLEBRAND,UPDATE_VEHICLEBRAND,ADD_VEHICLEBRAND,UPDATE_TRANSFER_MOVEMENT,ADD_TRANSFER_MOVEMENT," +
            "SHOW_MODELOFITEM,ADD_MODELOFITEM,UPDATE_MODELOFITEM,ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES" +
            "ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT, ADD_CUSTOMER,UPDATE_CUSTOMER,SHOW_CUSTOMER,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpPost("insert"), Authorize("ADD_ITEM,UPDATE_ITEM")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }
        [HttpPost("getPictures"), Authorize("UPDATE_ITEM,ADD_ITEM,DETAILS_ITEM,LIST_ITEM,SHOW_VEHICLEBRAND,UPDATE_VEHICLEBRAND,ADD_VEHICLEBRAND,ADD_MODELOFITEM,UPDATE_MODELOFITEM,SHOW_MODELOFITEM,LIST_VEHICLEBRAND," +
            "ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES" +
            "ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT,ADD_CUSTOMER,UPDATE_CUSTOMER,SHOW_CUSTOMER,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }
        [HttpPost("addTecDocMissingVehicleBrands")]
        public ResponseData AddTecDocMissingVehicleBrands([FromBody] List<string> brands)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceVehicleBrand.AddTecDocMissingVehicleBrands(brands, userMail);

            result.objectData = dataSourceResult;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            result.flag = 1;
            return result;
        }

    }
}
