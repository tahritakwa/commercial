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
    [Route("api/deliveryType")]
    public class DeliveryTypeController : BaseController
    {
        private readonly IServiceDeliveryType _serviceDeliveryType;
        public DeliveryTypeController(IServiceProvider serviceProvider, ILogger<DeliveryTypeController> logger, IServiceDeliveryType serviceDeliveryType)
          : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _serviceDeliveryType = serviceDeliveryType;
        }
        [HttpGet("getDataDropdown"), Authorize("ADD_CUSTOMER,SHOW_CUSTOMER,ADD_SUPPLIER,UPDATE_SUPPLIER,LIST_DELIVERY_SALES"),
            Authorize("ADD_DELIVERY_SALES")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }

        [HttpPost("getDataSourcePredicate"), Authorize("ADD_CUSTOMER,SHOW_CUSTOMER")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_CUSTOMER,SHOW_CUSTOMER,ADD_SUPPLIER,UPDATE_SUPPLIER,LIST_DELIVERY_SALES,ADD_DELIVERY_SALES,SHOW_DELIVERY_SALES,UPDATE_CUSTOMER," +
            "UPDATE_DELIVERY_SALES,SHOW_SUPPLIER")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {

            return base.GetDataDropdownWithPredicate(model);
        }

    }
}
