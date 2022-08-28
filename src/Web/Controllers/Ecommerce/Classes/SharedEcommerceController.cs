using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Services.Specific.Ecommerce.Interfaces;
using Services.Specific.Inventory.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales.Document;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;

namespace Web.Controllers.Ecommerce.Classes
{
    [Route("api/SharedEcommerce/")]
    public class SharedEcommerceController : BaseController
    {
        private readonly IServiceSharedEcommerce _serviceSharedEcommerce;
        private readonly IServiceStockDocument _serviceStockDocument;
        private readonly IServiceItem _serviceItem;
        const string idConst = "Id";
        private readonly DbSettings _dbConnectionSetting;
        public SharedEcommerceController(IOptions<AppSettings> appSettings, IServiceProvider serviceProvider, ILogger<BaseController> logger, IServiceSharedEcommerce serviceSharedEcommerce,
            IServiceStockDocument serviceStockDocument, IServiceItem serviceItem)
           : base(serviceProvider, logger)
        {
            _serviceSharedEcommerce = serviceSharedEcommerce;
            _serviceStockDocument = serviceStockDocument;
            _serviceItem = serviceItem;
            _dbConnectionSetting = appSettings.Value.ECommerceConfig.DbSettings;
        }
        /// <summary>
        /// warehouse filter 
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("warehouseFilter")]
        public virtual ResponseData WarehouseFilter([FromBody] ItemFilterPeerWarehouseViewModel model)
        {
            ResponseData result = new ResponseData();

            bool hasRole = SpecificAuthorizationCheck.CheckAuthorizationByName("LIST-ItemEcomm", Request.HttpContext) &&
                model.filtersItemDropdown.fromEcommerce;
            bool hasRole2 = SpecificAuthorizationCheck.CheckAuthorizationByName("LIST-Item", Request.HttpContext) &&
                !model.filtersItemDropdown.fromEcommerce;

            bool hasRole3 = SpecificAuthorizationCheck.CheckAuthorizationByName("LIST-SEARCHITEM", Request.HttpContext) &&
                !model.filtersItemDropdown.fromEcommerce;

            bool hasRole4 = SpecificAuthorizationCheck.CheckAuthorizationByName("LIST-ITEMSEARCH", Request.HttpContext) &&
                !model.filtersItemDropdown.fromEcommerce;

            bool hasRole5 = SpecificAuthorizationCheck.CheckAuthorizationByName("LIST-ITEMPURCHASE", Request.HttpContext) &&
                !model.filtersItemDropdown.fromEcommerce;

            if (!hasRole && !hasRole2 && !hasRole3 && !hasRole4 && !hasRole5)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }  
            else
            {
                var dataSourceResult = _serviceItem.FilterItemsByWarehouse(model);

                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        
        }
        /// <summary>
        /// get Stock Document With StockDocumentLine
        /// </summary>
        /// <param name="documentLinesWithPagingViewModel"></param>
        /// <returns></returns>
        [HttpPost("getStockDocumentWithStockDocumentLine")]
        public ResponseData GetStockDocumentWithStockDocumentLine([FromBody] DocumentLinesWithPagingViewModel documentLinesWithPagingViewModel)

        {
            var dataSourceResult = _serviceStockDocument.GetStockDocumentWithStockDocumentLine(documentLinesWithPagingViewModel, out int total);
            ResponseData result = new ResponseData
            {
                flag = 2,
                customStatusCode = CustomStatusCode.GetSuccessfull

            };
            result.listObject = new ListObject
            {
                listData = dataSourceResult,
                total = total
            };
            return result;

        }
        /// <summary>
        /// insert StockDocumentLine In Real Time
        /// </summary>
        /// <param name="objectSaved"></param>
        /// <returns></returns>
        [HttpPost("insertStockDocumentLineInRealTime")]
        public ResponseData InsertStockDocumentLineInRealTime([FromBody] StockDocumentLineViewModel objectSaved)
        {
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(DocumentEnumerator.TransferMovement, AutorizationActionConstants.AuthorizationAdd);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                _serviceStockDocument.AddLineInRealTime(objectSaved);
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.AddSuccessfull,
                    flag = 1
                };
            }
        }
        /// <summary>
        /// validate Ecommerce Transfert Movement
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("validateEcommerceTransfertMovement")]
        public ResponseData validateEcommerceTransfertMovement([FromBody] int id)
        {
            if (id == null)
            {
                throw new ArgumentNullException(nameof(id));
            }
            _serviceSharedEcommerce.ValidateEcommerceTransfertMovement(id);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = 1
            };
            return result;
        }
        /// <summary>
        /// transfert Validate StockDocument From Ecommerce
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("transfertValidateStockDocumentFromEcommerce")]
        public ResponseData TransfertValidateStockDocumentFromEcommerce([FromBody] ObjectToSaveViewModel objectToSave)
        {
            ResponseData result = TransfertValidateStockDocument(objectToSave);
            result.customStatusCode = CustomStatusCode.SuccessfullWithoutSuccessNotification;
            return result;
        }
        /// <summary>
        /// transfert Validate StockDocument
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("transfertValidateStockDocument")]
        public ResponseData TransfertValidateStockDocument([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            string documentTypeCode = GetDocumentTypeCode(int.Parse(objectToSave.model, CultureInfo.InvariantCulture));
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentTypeCode, AutorizationActionConstants.AuthorizationValidate);
            bool hasRole2 = SpecificAuthorizationCheck.CheckAuthorizationByName("ADD-StockMovementLineEcomm", Request.HttpContext);
            if (!hasRole && !hasRole2)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                ResponseData result = new ResponseData
                {
                    objectData = _serviceStockDocument.TransfertValidateStockDocument(int.Parse(objectToSave.model, CultureInfo.InvariantCulture)),
                    customStatusCode = CustomStatusCode.SuccessValidation,
                    flag = 1
                };
                return result;
            }
        }
        /// <summary>
        /// get document type code from document id
        /// </summary>
        /// <param name="id">document id</param>
        /// <returns>document type code</returns>
        private string GetDocumentTypeCode(int id)
        {
            IList<FilterViewModel> filters = new List<FilterViewModel>{
                new FilterViewModel
                {
                    Prop = idConst,
                    Value = id,
                    Operation = Operation.Equals
                }
            };
            return _serviceStockDocument.FindNoTrackedModelBy(filters.ToList()).FirstOrDefault().TypeStockDocument;
        }
        /// <summary>
        /// receive Validate StockDocument
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("receiveValidateStockDocument")]
        public ResponseData ReceiveValidateStockDocument([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            string documentTypeCode = GetDocumentTypeCode(int.Parse(objectToSave.model, CultureInfo.InvariantCulture));
            bool hasRole2 = SpecificAuthorizationCheck.CheckAuthorizationByName("ADD-StockMovementLineEcomm", Request.HttpContext);
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentTypeCode, AutorizationActionConstants.AuthorizationValidate);
            if (!hasRole && !hasRole2)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                ResponseData result = new ResponseData
                {
                    objectData = _serviceStockDocument.ReceiveValidateStockDocument(int.Parse(objectToSave.model, CultureInfo.InvariantCulture)),
                    customStatusCode = CustomStatusCode.SuccessValidation,
                    flag = 1
                };
                return result;
            }
        }
        /// <summary>
        /// Ecommerce StockDocument
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("ecommerceStockDocument")]
        public ResponseData EcommerceStockDocument([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            string documentTypeCode = GetDocumentTypeCode(int.Parse(objectToSave.model, CultureInfo.InvariantCulture));
            bool hasRole = SpecificAuthorizationCheck.CheckAuthorizationByName("ADD-StockMovementLineEcomm", Request.HttpContext);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {


                ResponseData result = new ResponseData
                {
                    objectData = _serviceStockDocument.ValidateStockDocumentById(int.Parse(objectToSave.model, CultureInfo.InvariantCulture), null),
                    customStatusCode = CustomStatusCode.SuccessfullWithoutSuccessNotification,
                    flag = 1
                };
                return result;
            }
        }
        /// <summary>
        /// delete Line In Real Time
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("deleteLineInRealTime")]
        public ResponseData DeleteLineInRealTime([FromBody] int id)
        {
            ResponseData result = new ResponseData();
            
           
            {
                _serviceStockDocument.DeleteLineInRealTime(id);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.DeleteSuccessfull;

            }
            return result;
        }
        /// <summary>
        /// get Item Quantity In Warehouse
        /// </summary>
        /// <param name="objectToSend"></param>
        /// <returns></returns>
        [HttpPost("getItemQtyInWarehouse")]
        public ResponseData GetItemQtyInWarehouse([FromBody] ObjectToSaveViewModel objectToSend)
        {

            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(DocumentEnumerator.InventoryMovement, AutorizationActionConstants.AuthorizationAdd);
            bool hasRole2 = SpecificAuthorizationCheck.CheckAuthorizationByName("LIST-ItemEcomm", Request.HttpContext);
            if (!hasRole && !hasRole2)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                dynamic instanceType = JsonConvert.DeserializeObject(objectToSend.model.ToString());
                ResponseData result = new ResponseData
                {
                    listObject = new ListObject
                    {
                        listData = _serviceStockDocument.GetItemQtyInWarehouse((int)instanceType["IdItem"].Value, (int)instanceType["IdWarehouse"].Value,
                        (int)instanceType["Id"].Value)
                    },
                    flag = 2,
                    customStatusCode = CustomStatusCode.GetSuccessfull
                };
                return result;
            }
        }

        
    }
}
