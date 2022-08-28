using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.ErpSettings.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.ErpSettings.Classes
{
    [Route("api/reportTemplate")]
    public class ReportTemplateController : BaseController
    {
        private readonly IServiceReportTemplate _serviceReportTemplate;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public ReportTemplateController(IServiceProvider serviceProvider, IServiceReportTemplate serviceReportTemplate, ILogger<ReportTemplateController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceReportTemplate = serviceReportTemplate;
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES,LIST_FINANCIAL_ASSET_SALES," +
            "ADD_DELIVERY_SALES,ADD_ORDER_QUOTATION_PURCHASE,ADD_FINAL_ORDER_PURCHASE,ADD_RECEIPT_PURCHAS,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE," +
            "UPDATE_RECEIPT_PURCHASE,UPDATE_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,UPDATE_EXIT_VOUCHERS,SHOW_ORDER_QUOTATION_PURCHASE," +
            "SHOW_RECEIPT_PURCHASE,SHOW_INVOICE_PURCHASE,SHOW_ADMISSION_VOUCHERS,SHOW_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,SHOW_ORDER_QUOTATION_PURCHASE,SHOW_FINAL_ORDER_PURCHASE,SHOW_ASSET_PURCHASE,ADD_QUOTATION_SALES," +
            "UPDATE_QUOTATION_SALES,SHOW_QUOTATION_SALES,SHOW_FINANCIAL_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,SHOW_INVOICE_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES," +
            "ADD_ORDER_SALES,UPDATE_ORDER_SALES,SHOW_ORDER_SALES,UPDATE_VALID_ORDER_SALES,SHOW_ASSET_SALES,UPDATE_ASSET_SALES,ADD_ASSET_SALES,UPDATE_VALID_ASSET_SALES,SHOW_INVOICE_SALES,UPDATE_INVOICE_SALES," +
            "ADD_INVOICE_SALES,SHOW_DELIVERY_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
