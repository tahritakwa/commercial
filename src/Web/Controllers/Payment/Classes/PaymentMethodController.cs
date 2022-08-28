using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Payment.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;
using Web.Controllers.Payment.Interfaces;

namespace Web.Controllers.Payment.Classes
{
    [Route("api/paymentMethod")]
    public class PaymentMethodController : BaseController, IPaymentMethodController

    {
        readonly IServicePaymentMethod _servicePaymentMethod;
        public PaymentMethodController(IServicePaymentMethod servicePaymentMethod
           , IServiceProvider serviceProvider, ILogger<PaymentMethodController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _servicePaymentMethod = servicePaymentMethod;
        }
        [HttpGet("getDataDropdown"), Authorize("ADD_SETTLEMENTMODE,UPDATE_SETTLEMENTMODE,ADD_CUSTOMER_SETTLEMENT,ADD_SUPPLIER_SETTLEMENT,LIST_CUSTOMER_PAYMENT_HISTORY,LIST_SUPPLIER_PAYMENT_HISTORY")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_CUSTOMER_PAYMENT_HISTORY,LIST_SUPPLIER_PAYMENT_HISTORY,READONLY_CUSTOMER_PAYMENT_HISTORY,READONLY_SUPPLIER_PAYMENT_HISTORY")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
    }
}
