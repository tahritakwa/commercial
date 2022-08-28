using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Sales.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/settlementMode")]
    public class SettlementModeController : BaseController
    {
        private readonly IServiceSettlementMode _serviceSettlementMode;
        public SettlementModeController(IServiceProvider serviceProvider, ILogger<SettlementModeController> logger, IServiceSettlementMode serviceSettlementMode)
          : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _serviceSettlementMode = serviceSettlementMode;
        }
        [HttpGet("get"), Authorize("LIST_CUSTOMER,LIST_INVOICE_SALES,LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES,LIST_FINANCIAL_ASSET_SALES,ADD_INVOICE_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_ASSET_PURCHASE," +
            "UPDATE_ASSET_PURCHASE,SHOW_INVOICE_PURCHASE,SHOW_CUSTOMER,UPDATE_SUPPLIER,ADD_CUSTOMER,ADD_SUPPLIER,GENERATE_TERM_BILLING,UPDATE_CUSTOMER,SHOW_ASSET_PURCHASE,SHOW_FINANCIAL_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES," +
            "UPDATE_FINANCIAL_ASSET_SALES,SHOW_INVOICE_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,SHOW_ASSET_SALES,UPDATE_ASSET_SALES,ADD_ASSET_SALES,UPDATE_VALID_ASSET_SALES,SHOW_INVOICE_SALES," +
            "UPDATE_INVOICE_SALES,ADD_INVOICE_SALES,ADD_SERVICES_CONTRACT,SHOW_SERVICES_CONTRACT,UPDATE_SERVICES_CONTRACT")]
        public override ResponseData Get()
        {
            return base.Get();
        }
        [HttpPost("getDataSourcePredicate"), Authorize("ADD_SETTLEMENTMODE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return GetDataSourcePredicate(model);

        }


    }
}
