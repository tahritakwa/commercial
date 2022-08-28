using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Persistence;
using Services.Specific.Inventory.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Reporting.Generic;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/warehouse")]
    public class WarehouseController : BaseController, IWarehouseController
    {
        private readonly IServiceWarehouse _serviceWarehouse;
        private readonly IServiceShelf _serviceShelf;

        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public WarehouseController(IServiceProvider serviceProvider, IServiceWarehouse serviceWarehouse, ILogger<WarehouseController> logger, IServiceShelf serviceShelf) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceWarehouse = serviceWarehouse;
            _serviceShelf = serviceShelf;
        }
        [HttpPost("getWarehouseForInventory"), Authorize("LIST")]
        public virtual ResponseData GetWarehouseForInventory([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceWarehouse.GetWarehouseForInventory(model);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

            return result;
        }
        [HttpGet("getCentralWarehouse"), Authorize("LIST_WAREHOUSE,ADD_ITEM,DETAILS_ITEM")]
        public ResponseData GetCentralWarehouse()
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _serviceWarehouse.GetCentralWarehouse();
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
                result.flag = 1;
            }
            return result;
        }


        [HttpPost("getWarehouseList"), Authorize("LIST_WAREHOUSE")]
        public ResponseData GetWarehouseList([FromBody] ObjectToSaveViewModel objectSaved)
        {
            ResponseData result = new ResponseData();
            string searchWarehouse = "";
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                if (objectSaved.model != null)
                {
                    searchWarehouse = objectSaved.model;
                }
                result.listObject = new ListObject
                {
                    listData = _serviceWarehouse.GetListOfWarehouses(searchWarehouse)
                };
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
            }
            return result;
        }

        /// <summary>
        /// delete entity
        /// </summary>
        /// <param name="model"> entity</param>
        /// <returns> respons HTTP :
        /// ResponseJson.Success if The entity is deleted
        /// ResponseJson.Failed if The entity is not deleted
        /// ResponseJson.BadRequest if the params was null
        /// </returns>
        [HttpDelete("deleteWarehouse/{id}"), AllowAnonymous]
        public virtual ResponseData DeleteWarehouse(int id)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                _serviceWarehouse.DeleteWarehouse(id, modelName, userMail);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.DeleteSuccessfull;

            }
            return result;
        }


        [HttpPost("getWarehouseDropdownForInventory"), Authorize("LIST_WAREHOUSE,LIST_ITEM,ADD_ITEM,UPDATE_ITEM,LIST_INVENTORY_MOVEMENT,LIST_TRANSFER_MOVEMENT,LIST_SHELFS_AND_STORAGES,GENERATE_SALES_JOURNAL," +
            "LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES,LIST_QUICK_SALES,LIST_PRICES,ADD_CLAIM_PURCHASE,UPDATE_CLAIM_PURCHASE,ADD_PURCHASE_REQUEST," +
            "UPDATE_PURCHASE_REQUEST,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,ADD_ORDER_QUOTATION_PURCHASE,ADD_FINAL_ORDER_PURCHASE,ADD_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE," +
            "UPDATE_FINAL_ORDER_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,UPDATE_EXIT_VOUCHERS," +
            "UPDATE_VALID_ADMISSION_VOUCHERS,UPDATE_VALID_EXIT_VOUCHERS,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,ADD_PROVISIONING,UPDATE_PROVISIONING,DETAILS_ITEM" +
            "ADD_REPAIR_ORDER,UPDATE_REPAIR_ORDER,ADD_INTERVENTION, UPDATE_INTERVENTION, ADD_OPERATIONKIT, UPDATE_OPERATIONKIT,COUNTER_SALES")]
        public virtual ResponseData GetWarehouseDropdownForInventory([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceWarehouse.GetWarehouseDropdownForInventory(model);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

            return result;
        }

        [HttpPost("getWarehouseDropdownForEcommerce"), Authorize("DROPDOWNLIST")]
        public virtual ResponseData GetWarehouseDropdownForEcommerce([FromBody] PredicateFormatViewModel model)
        {
            bool hasRole = SpecificAuthorizationCheck.CheckAuthorizationByName("SHOW-StockMovementLineEcomm", Request.HttpContext);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceWarehouse.GetWarehouseDropdownForEcommerce(model);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

            return result;
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES,LIST_FINANCIAL_ASSET_SALES," +
            "ADD_DELIVERY_SALES,ADD_PURCHASE_REQUEST,ADD_PRICEREQUEST,UPDATE_PRICEREQUEST,ADD_ORDER_QUOTATION_PURCHASE,ADD_FINAL_ORDER_PURCHASE,ADD_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE," +
            "UPDATE_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS," +
            "UPDATE_EXIT_VOUCHERS,LIST_STOCK_VALUATION,SHOW_ORDER_QUOTATION_PURCHASE,SHOW_RECEIPT_PURCHASE,SHOW_INVOICE_PURCHASE,SHOW_ADMISSION_VOUCHERS,SHOW_EXIT_VOUCHERS,ADD_WAREHOUSE,ADD_TRANSFER_MOVEMENT," +
            "SHOW_TRANSFER_MOVEMENT,SHOW_WAREHOUSE,SHOW_DELIVERY_SALES,UPDATE_WAREHOUSE,UPDATE_TRANSFER_MOVEMENT,UPDATE_DELIVERY_SALES,SHOW_ORDER_QUOTATION_PURCHASE,SHOW_FINAL_ORDER_PURCHASE,SHOW_PRICEREQUEST," +
            "SHOW_ORDER_PRICE_REQUEST,SHOW_UPDATE_ORDER_PRICE_REQUEST,SHOW_QUOTATION_PRICE_REQUEST,SHOW_ASSET_PURCHASE,SHOW_QUOTATION_SALES,ADD_QUOTATION_SALES,UPDATE_QUOTATION_SALES,SHOW_FINANCIAL_ASSET_SALES," +
            "ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,SHOW_INVOICE_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,SHOW_ORDER_SALES,UPDATE_ORDER_SALES,ADD_ORDER_SALES,UPDATE_VALID_ORDER_SALES," +
            "SHOW_ASSET_SALES,UPDATE_ASSET_SALES,ADD_ASSET_SALES,UPDATE_VALID_ASSET_SALES,SHOW_INVOICE_SALES,UPDATE_INVOICE_SALES,ADD_INVOICE_SALES,ADD_ZONE,ADD_WAREHOUSE,ADD_SHELF_STORAGE,UPDATE_PURCHASE_REQUEST," +
            "SHOW_PURCHASE_REQUEST, COUNTER_SALES,ADD_CASH_MANAGEMENT,UPDATE_CASH_MANAGEMENT")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }

        [HttpGet("getShelfByWarehouse/{id}"), Authorize("ADD_SHELFS_AND_STORAGES,LIST_SHELFS_AND_STORAGES,LIST_WAREHOUSE,DETAILS_ITEM,ADD_ITEM,UPDATE_ITEM,ADD_ZONE")]
        public virtual ResponseData GetShelfByWarehouse(int id)
        {
            ResponseData result = new ResponseData();
            result.objectData = _serviceShelf.getShelfsByWarehouse(id);
            result.customStatusCode = CustomStatusCode.GetSuccessfull;
            result.flag = 1;
            return result;
        }

        /// <summary>
        /// Check if warehouse name already exists
        /// </summary>
        /// <param name="warehouse"></param>
        /// <returns></returns>
        [HttpPost("checkWarehouseNameExistence"), Authorize("ADD_ZONE,ADD_WAREHOUSE,UPDATE_ZONE")]
        public bool CheckWarehouseNameExistence([FromBody] WarehouseViewModel warehouse)
        {
            return _serviceWarehouse.CheckWarehouseNameExistence(warehouse);
        }
        [HttpPost("insert"), Authorize("ADD_WAREHOUSE")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            bool hasRole = (bool)objectSaved.model.IsWarehouse ? RoleHelper.HasPermission("ADD_WAREHOUSE") : RoleHelper.HasPermission("ADD_ZONE");
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            return base.Post(files, objectSaved, objectJsonToSave);
        }

        [HttpPut("update"), Authorize("UPDATE_ZONE")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            bool hasRole = (bool)objectSaved.model.IsWarehouse ? RoleHelper.HasPermission("UPDATE_WAREHOUSE") : RoleHelper.HasPermission("UPDATE_ZONE");
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            return base.Put(files, objectSaved, objectJsonToSave);
        }
        [HttpPost("downloadJasperDocumentReport"), Authorize("PRINT_STOCK_VALUATION")]
        public override Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            return base.DownloadJasperDocumentReport(data);
        }
        [HttpDelete("delete/{id}"), Authorize("DELETE_ZONE")]
        public override ResponseData Delete(int id)
        {
            WarehouseViewModel warehouse = _serviceWarehouse.GetModelById(id);
            bool hasRole = warehouse.IsWarehouse ? RoleHelper.HasPermission("DELETE_WAREHOUSE") : RoleHelper.HasPermission("DELETE_ZONE");
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            return base.Delete(id);
        }
        [HttpPost("getPredicateWarehouseForGarage")]
        public ResponseData GetDataSourcePredicateForGarage([FromBody] PredicateFormatViewModel predicate)
        { 
            return base.GetDataSourcePredicate(predicate);
        }

    }
}