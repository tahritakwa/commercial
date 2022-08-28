using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Payment.Classes
{
    [Route("api/paymentType")]
    public class PaymentTypeController : BaseController
    {
        public PaymentTypeController(IServiceProvider serviceProvider, ILogger<PaymentTypeController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpGet("getDataDropdown"), Authorize("LIST_EMPLOYEE")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_EMPLOYEE,UPDATE_EMPLOYEE,SHOW_EMPLOYEE,TICKET_PAYMENT,LIST_CUSTOMER_OUTSTANDING_DOCUMENT,LIST_SUPPLIER_OUTSTANDING_DOCUMENT")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_TRANSFERORDER")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
