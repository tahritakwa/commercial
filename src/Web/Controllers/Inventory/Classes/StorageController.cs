using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Inventory.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/storage")]
    public class StorageController : BaseController, IStorageController
    {
        private readonly IServiceStorage _serviceStorage;
        public StorageController(IServiceProvider serviceProvider, ILogger<StorageController> logger, IServiceStorage serviceStorage) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceStorage = serviceStorage;
        }

        [HttpDelete("delete/{id}"), Authorize("DELETE_WAREHOUSE,DELETE_SHELF_STORAGE")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }

    }
}