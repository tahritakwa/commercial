using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.Sales.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Common;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/vehicle")]
    public class VehicleController : BaseController
    {
        private readonly IServiceSaleSettings _serviceSaleSettings;
        private readonly IServiceVehicle _vehicleService;
        public VehicleController(IServiceProvider serviceProvider, ILogger<VehicleController> logger, IServiceVehicle vehicleService)
          : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _vehicleService = vehicleService;
        }

        [HttpGet("getDataDropdown"), Authorize("LIST_CUSTOMER")]

        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpPost("getUnicity"), Authorize("UPDATE_CUSTOMER")]
        public override bool GetUnicity([FromBody] object objectToCheck)
        {
            return base.GetUnicity(objectToCheck);
        }
    }
}
