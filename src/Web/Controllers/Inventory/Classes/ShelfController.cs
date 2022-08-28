using Infrastruture.Utility;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Persistence;
using Services.Specific.Inventory.Interfaces;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Inventory;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/shelf")]
    public class ShelfController : BaseController, IShelfController
    {
        private readonly IServiceShelf _serviceShelf;
        public ShelfController(IServiceProvider serviceProvider, ILogger<ShelfController> logger, IServiceShelf serviceShelf) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceShelf = serviceShelf;
        }


        [HttpPost("createNewShelfStorage")]
        public ResponseData CreateNewShelfStorage([FromBody] ShelfViewModel shelf)
        {
            //GetUserMail();
            ResponseData result = new ResponseData();
            bool hasRole = false;
            if (shelf.Id == 0)
            {
                hasRole = RoleHelper.HasPermission("ADD_SHELF_STORAGE");
            }
            else
            {
                hasRole = RoleHelper.HasPermission("UPDATE_SHELF_STORAGE");
            }
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            var res = _serviceShelf.addShelfAndStorage(shelf, userMail);
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.objectData = res;
            result.flag = 1;
            return result;
        }

        /// <summary>
        /// Check if shelf and storage already exists in warehouse
        /// </summary>
        /// <param name="shelf"></param>
        /// <returns></returns>
        [HttpPost("checkShelfAndStorageExistenceInWarehouse"), Authorize("ADD_SHELF_STORAGE")]
        public bool CheckShelfAndStorageExistenceInWarehouse([FromBody] ShelfViewModel shelf)
        {
            return _serviceShelf.CheckShelfAndStorageExistenceInWarehouse(shelf);
        }
    }
}
