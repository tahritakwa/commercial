using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.Inventory.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Inventory;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/itemWarehouse")]
    public class ItemWarehouseController : BaseController, IItemWarehouseController
    {
        private readonly IServiceItemWarehouse _serviceItemWarehouse;
        public ItemWarehouseController(IServiceProvider serviceProvider,
            IServiceItemWarehouse serviceItemWarehouse, ILogger<ItemWarehouseController> logger,
            IOptions<OtherDataBaseSettings> appSettings) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceItemWarehouse = serviceItemWarehouse;
        }

        [HttpPost("getStorageDataSourceFromWarhouse"), Authorize("LIST_SHELFS_AND_STORAGES")]
        public virtual ResponseData GetStorageDataSourceFromWarhouse([FromBody] ItemWarehouseViewModel itemWarehouse)
        {
            ResponseData result = new ResponseData();
            result.objectData = _serviceItemWarehouse.getStorageDataSourceFromWarhouse(itemWarehouse);
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpPost("getShelfDataSourceFromWarhouse"), Authorize("LIST_INVENTORY_MOVEMENT,LIST_SHELFS_AND_STORAGES")]
        public virtual ResponseData GetShelfDataSourceFromWarhouse([FromBody] int idWarehouse)
        {
            ResponseData result = new ResponseData();
            result.objectData = _serviceItemWarehouse.getShelfDataSourceFromWarhouse(idWarehouse);
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }
        [HttpPost("generateItemsFromShelfAndStorage"), Authorize("LIST_SHELFS_AND_STORAGES")]
        public virtual ResponseData generateItemsFromShelfAndStorage([FromBody] object dataObject)
        {
            var dataSourceResult = _serviceItemWarehouse.GenerateItemsFromShelfAndStorage(dataObject);
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                },
                flag = 2,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }

        [HttpPost("ChangeItemStorage"), Authorize("VALIDATE_SHELFS_AND_STORAGES")]
        public virtual ResponseData ChangeItemStorage([FromBody] List<ShelfStorageManagementViewModel> itemWarehouseViewModel)
        {
            _serviceItemWarehouse.ChangeItemStorage(itemWarehouseViewModel);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.UpdateSuccessfull
            };
            return result;
        }

        [HttpPost("getItemWarehouseData")]
        public ResponseData GetItemWarehouseData([FromBody] ShelfStorageManagementViewModel itemWarehouseViewModel)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceItemWarehouse.GetItemWarehouseData(itemWarehouseViewModel),
                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };

            return result;
        }
        [HttpPost("ChangeOneItemtorage"), Authorize("LIST_SHELFS_AND_STORAGES")]
        public virtual ResponseData ChangeOneItemtorage([FromBody] ShelfStorageManagementViewModel itemWarehouseViewModel)
        {
            _serviceItemWarehouse.ChangeItemStorage(itemWarehouseViewModel);
            ResponseData result = new ResponseData
            {
                flag = 1
            };
            return result;
        }
        /// <summary>
        /// Get data with predicate and specific filter
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("GetDataWarehouseWithSpecificFilter")]
        public virtual ResponseData GetDataWarehouseWithSpecificFilter([FromBody] List<PredicateFormatViewModel> model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _service.GetDataWarehouseWithSpecificFilter(model);

                result.listObject = new ListObject
                {
                    listData = dataSourceResult
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_SHELFS_AND_STORAGES,LIST_DELIVERY_SALES,ADD_DELIVERY_SALES,UPDATE_EXIT_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_VALID_DELIVERY_SALES,UPDATE_DELIVERY_SALES")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }

}
