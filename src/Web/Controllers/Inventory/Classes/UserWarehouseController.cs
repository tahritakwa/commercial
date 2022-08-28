using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.Inventory.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/userWarehouse")]
    public class UserWarehouseController : BaseController
    {
        private readonly IServiceUserWarehouse _serviceUserWarehouse;
        public UserWarehouseController(IServiceProvider serviceProvider, IServiceUserWarehouse serviceUserWarehouse, ILogger<UserWarehouseController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceUserWarehouse = serviceUserWarehouse;
        }

        /// <summary>
        /// api to update user in warehouse
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost("updateUserWarehouse")]
        public ResponseData UpdateUserWarehouse([FromBody] dynamic data)
        {
            _serviceUserWarehouse.UpdateUserWarehouse((string)data.email, (int?)data.idWarehouse);
            ResponseData result = new ResponseData();
            result.flag = 1;
            return result;
        }

        /// <summary>
        /// api to get warehouse by user email 
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        [HttpPost("getWarehouse")]
        public ResponseData GetIdWarehouse([FromBody] string email)
        {
            ResponseData result = new ResponseData();
            result.objectData = _serviceUserWarehouse.GetWarehouse(email);
            return result;
        }
    }
}
