using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.ErpSettings.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.ErpSettings.Interfaces;
using Web.Controllers.GenericController;

namespace Web.Controllers.ErpSettings.Classes
{
    [Route("api/information")]
    public class InformationController : BaseController, IInformationController
    {
        private readonly IServiceInformation _serviceInformation;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public InformationController(IServiceProvider serviceProvider, IServiceInformation serviceInformation, ILogger<InformationController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceInformation = serviceInformation;
        }
        [HttpPost("getModelByCondition"), Authorize("ADD_TRANSFER_MOVEMENT,UPDATE_TRANSFER_MOVEMENT,LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,LIST_ASSET_SALES," +
            "LIST_INVOICE_ASSET_SALES,ADD_DELIVERY_SALES,LIST_FINANCIAL_ASSET_SALES,LIST_RECRUITMENTREQUEST,LIST_RECRUITMENTOFFER,ADD_PURCHASE_REQUEST,UPDATE_PURCHASE_REQUEST,LIST_PURCHASE_REQUEST," +
            "ADD_ORDER_QUOTATION_PURCHASE,ADD_FINAL_ORDER_PURCHASE,ADD_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE,UPDATE_RECEIPT_PURCHASE," +
            "UPDATE_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,UPDATE_EXIT_VOUCHERS,LIST_EXITEMPLOYEE,LIST_EXITEMPLOYEE,ADD_TRANSFER_MOVEMENT," +
            "SHOW_TRANSFER_MOVEMENT,ADD_SHELFS_AND_STORAGES,SHOW_SHELFS_AND_STORAGES,SHOW_INVENTORY_MOVEMENT,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_ORDER_QUOTATION_PURCHASE,SHOW_ORDER_QUOTATION_PURCHASE," +
            "SHOW_FINAL_ORDER_PURCHASE,SHOW_ASSET_PURCHASE,ADD_QUOTATION_SALES,UPDATE_QUOTATION_SALES,SHOW_QUOTATION_SALES,SHOW_RECEIPT_PURCHASE,SHOW_FINANCIAL_ASSET_SALES," +
            "ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,SHOW_INVOICE_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_ORDER_SALES,ADD_ORDER_SALES,SHOW_ASSET_SALES,UPDATE_ASSET_SALES," +
            "ADD_ASSET_SALES,VALIDATE_INVOICE_SALES,UPDATE_INVOICE_SALES,ADD_INVOICE_SALES,LIST_SHELFS_AND_STORAGES,VALIDATE_DELIVERY_SALES,LIST_INVENTORY_MOVEMENT")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }

    }
}
