using Infrastruture.Utility;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Services.Specific.Ecommerce.Interfaces;
using Services.Specific.Inventory.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales.Document;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/stockDocument")]
    public class StockDocumentController : BaseController
    {
        const string roles = "roles";
        const string documentTypeCodeConst = "TypeStockDocument";
        const string idConst = "Id";
        const StringComparison stringComparison = StringComparison.InvariantCultureIgnoreCase;
        private readonly IServiceStockDocument _serviceStockDocument;
        private readonly IServiceStockDocumentLine _serviceStockDocumentLine;
        private readonly IServiceEcommerce _serviceTriggerItem;
        private readonly DbSettings _dbConnectionSetting;
        protected readonly AppSettings _appSettings;
        public StockDocumentController(IOptions<AppSettings> appSettings, IServiceEcommerce serviceTriggerItem, IServiceStockDocument serviceStockDocument, IServiceStockDocumentLine serviceStockDocumentLine, IServiceProvider serviceProvider, ILogger<StockDocumentController> logger) : base(serviceProvider, logger, appSettings)
        {
            _serviceStockDocument = serviceStockDocument;
            _serviceStockDocumentLine = serviceStockDocumentLine;
            _serviceTriggerItem = serviceTriggerItem;
            if (appSettings != null)
            {
                _appSettings = appSettings.Value;
                _dbConnectionSetting = appSettings.Value.ECommerceConfig.DbSettings;
            }

        }

        [HttpGet("getStockDocumentById/{id}")]
        public ResponseData GetStockDocumentById(int id)
        {
            ResponseData result = base.GetById(id);
            StockDocumentViewModel stockDocumentViewModel = (StockDocumentViewModel)result.objectData;
            string documentTypeCode = stockDocumentViewModel.TypeStockDocument;
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentTypeCode, AutorizationActionConstants.AuthorizationShow);
            return (hasRole) ? result : new ResponseData
            {
                customStatusCode = CustomStatusCode.Unauthorized
            };
        }

        [HttpPost("getInventoryMovementList")]
        public ResponseData GetInventoryMovementList([FromBody] PredicateWithDateFilterInformationViewModel model)
        {

            if (model.Predicate == null)
            {
                throw new ArgumentNullException(nameof(model.Predicate));
            }
            string documentTypeCode = model.Predicate.Filter.FirstOrDefault(p => string.Compare(p.Prop, documentTypeCodeConst, stringComparison) == 0).Value.ToString();
            bool hasRole = RoleHelper.HasPermission("LIST-StockMovementEcomm");
            bool hasRole2 = RoleHelper.HasPermission("LIST_INVENTORY_MOVEMENT");
            bool hasRole3 = RoleHelper.HasPermission("LIST_TRANSFER_MOVEMENT");
            if (!hasRole && !hasRole2 && !hasRole3)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }

            var dataSourceResult = _serviceStockDocument.GetInventoryMovementList(model);
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

        [HttpPost("getStockDocumentList")]
        public ResponseData GetStockDocumentList([FromBody] PredicateFormatViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            string documentTypeCode = model.Filter.FirstOrDefault(p => string.Compare(p.Prop, documentTypeCodeConst, stringComparison) == 0).Value.ToString();
            bool hasRole = SpecificAuthorizationCheck.CheckAuthorizationByName("LIST-StockMovementEcomm", Request.HttpContext);
            bool hasRole2 = SpecificAuthorizationCheck.DocumentAuthorization(documentTypeCode, AutorizationActionConstants.AuthorizationList);
            if (!hasRole && !hasRole2)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }

            var dataSourceResult = _serviceStockDocument.GetStockDocumentList(model);
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

        [HttpPost("getStockInventoryDocument"), Authorize("UPDATE_INVENTORY_MOVEMENT,ADD_INVENTORY_MOVEMENT,SHOW_INVENTORY_MOVEMENT")]
        public ResponseData PostStockInventoryDocument(IList<IFormFile> files, [FromBody] PredicateFormatViewModel model, string objectJsonToSave)
        {

            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }

            StockDocumentViewModel instanceType = _serviceStockDocument.GetModelWithRelations(model);
            GetUserMail();

            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
                objectData = instanceType,
                flag = 1
            };

            return result;
        }

        [HttpPost("getStockDailyInventoryDocumentLine"), Authorize("GENERATE_SALES_JOURNAL")]
        public ResponseData GetStockDailyInventoryDocumentLine([FromBody] List<PredicateFormatViewModel> predicateModel)
        {
            if (predicateModel == null)
            {
                throw new ArgumentNullException(nameof(predicateModel));
            }

            GetUserMail();
            var data = _serviceStockDocumentLine.GetStockDailyDocumentLineList(predicateModel, true);
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = data,
                    total = data.Count()
                },
                flag = 2,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
            };

            return result;
        }

        [HttpPost("getInventoryDocumentLine"), Authorize("LIST")]
        public ResponseData GetInventoryDocumentLine([FromBody] InventoryDocumentViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }

            GetUserMail();
            var data = _serviceStockDocumentLine.GetStockInventoryDocumentLine(model, true);
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = data.data,
                    total = data.total
                },
                flag = 2,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
            };

            return result;
        }

        [HttpPost("getStockInventoryDocumentLine"), Authorize("UPDATE_INVENTORY_MOVEMENT,ADD_INVENTORY_MOVEMENT,SHOW_INVENTORY_MOVEMENT")]
        public ResponseData PostStockInventoryDocumentLine([FromBody] InventoryDocumentViewModel model)
        {

            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }

            StockDocumentViewModel instanceType = _serviceStockDocument.FindModelBy(x => x.Id == model.IdStockDocument).FirstOrDefault();
            GetUserMail();
            var dataSourceResult = _serviceStockDocumentLine.GetStockDocumentLineList(model);
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                },
                flag = 2,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
            };


            return result;
        }

        [HttpPost("massPrintInventoryDocuments"), Authorize(Roles = "LIST")]
        public ResponseData MassPrintInventoryDocuments([FromBody] List<StockDocumentViewModel> model)
        {
            throw new NotImplementedException();

        }

        [HttpPost("getItemTecDocByRefOrBarcode"), Authorize("LIST")]
        public ResponseData PostSearchStockInventoryDocumentLine([FromBody] InventoryDocumentLineViewModel model)
        {

            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }

            StockDocumentViewModel instanceType = _serviceStockDocument.FindModelBy(x => x.Id == model.IdStockDocument).FirstOrDefault();
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(instanceType.TypeStockDocument, AutorizationActionConstants.AuthorizationAdd);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            GetUserMail();
            hasRole = SpecificAuthorizationCheck.CheckAuthorizationByName("Show-isUserInInventoryListRole", Request.HttpContext);
            var dataSourceResult = _serviceStockDocumentLine.GetStockDocumentLineList(model, hasRole);
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                },
                flag = 2,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
            };


            return result;
        }

        [HttpPost("savePlannedInventoryStockDocument"), Authorize("ADD")]
        public ResponseData PostSavePlannedInventoryStockDocument(IList<IFormFile> files, [FromBody] StockDocumentViewModel model, string objectJsonToSave)
        {

            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }

            StockDocumentViewModel instanceType = _serviceStockDocument.FindByAsNoTracking(x => x.IdDocumentStatus == 1
            && x.IdWarehouseSource == model.IdWarehouseSource
            && x.IdWarehouseDestination == model.IdWarehouseDestination).FirstOrDefault(c =>
            c.DocumentDate.Value.Day == model.DocumentDate.Value.Day
            && c.DocumentDate.Value.Month == model.DocumentDate.Value.Month
            && c.DocumentDate.Value.Year == model.DocumentDate.Value.Year);
            if (instanceType != null)
            {
                bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(instanceType.TypeStockDocument, AutorizationActionConstants.AuthorizationAdd);
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
            }
            GetUserMail();

            ResponseData result;

            result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AddSuccessfull,
                objectData = _serviceStockDocument.AddInventoryDocument(model, null, userMail),
                flag = 1
            };

            return result;
        }

        [HttpPost("insertStockInventoryDocument"), Authorize("ADD_INVENTORY_MOVEMENT")]
        public ResponseData PostStockInventoryDocument(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {

            StockDocumentViewModel stockDocument =
                JsonConvert.DeserializeObject<StockDocumentViewModel>(objectSaved.model.ToString());

            StockDocumentViewModel instanceType = _serviceStockDocument.FindByAsNoTracking(x => x.IdDocumentStatus == 1
            && x.IdWarehouseSource == stockDocument.IdWarehouseSource
            && x.IdWarehouseDestination == stockDocument.IdWarehouseDestination).FirstOrDefault(c =>
           c.DocumentDate.Value.Day == stockDocument.DocumentDate.Value.Day
           && c.DocumentDate.Value.Month == stockDocument.DocumentDate.Value.Month
           && c.DocumentDate.Value.Year == stockDocument.DocumentDate.Value.Year);
            GetUserMail();
            ResponseData result;

            result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AddSuccessfull,
                objectData = _serviceStockDocument.AddInventoryDocument(stockDocument, null, userMail),
                flag = 1
            };
            result.objectData.EntityName = "STOCKDOCUMENT";

            return result;
        }

        [HttpPost("addLineToInventoryDocument")]
        public ResponseData AddLineToInventoryDocument([FromBody] StockDocumentLineViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(DocumentEnumerator.InventoryMovement, AutorizationActionConstants.AuthorizationAdd);
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
                    listObject = new ListObject
                    {
                        listData = _serviceStockDocument.AddInventoryDocumentLine(objectToSave, null, null, userMail)
                    },
                    flag = 2,
                    customStatusCode = CustomStatusCode.GetSuccessfull
                };
                return result;
            }
        }

        [HttpPost("updateLineToInventoryDocument"), Authorize("UPDATE_INVENTORY_MOVEMENT,ADD_INVENTORY_MOVEMENT")]
        public ResponseData UpdateLineToInventoryDocument([FromBody] StockDocumentLineViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            GetUserMail();
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = _serviceStockDocument.UpdateInventoryDocumentLine(objectToSave, null, null, userMail)
                },
                flag = 2,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;

        }

        [HttpPost("validateInventoryStockDocument"), Authorize("VALIDATE_INVENTORY_MOVEMENT")]
        public ResponseData ValidateInventoryStockDocument([FromBody] int id)
        {

            ResponseData result = new ResponseData
            {
                objectData = _serviceStockDocument.ValidateInventoryDocument(id, userMail),
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = 1
            };
            return result;
        }

        [HttpPost("unvalidateInventoryStockDocument"), Authorize("UNVALIDATE_INVENTORY_MOVEMENT")]
        public ResponseData UnvalidateInventoryStockDocument([FromBody] int id)
        {

            ResponseData result = new ResponseData
            {
                objectData = _serviceStockDocument.UnvalidateInventoryDocument(id, userMail),
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = 1
            };
            return result;
        }



        [HttpPost("getItemQtyInWarehouse")]
        public ResponseData GetItemQtyInWarehouse([FromBody] ObjectToSaveViewModel objectToSend)
        {
            List<string> roles = new List<string>{"ADD_TRANSFER_MOVEMENT", "ItemEcomm", "ADD_INVENTORY_MOVEMENT","UPDATE_TRANSFER_MOVEMENT", "UPDATE_INVENTORY_MOVEMENT",
            "ADD_SHELFS_AND_STORAGES", "UPDATE_SHELFS_AND_STORAGES"};
            bool hasRole = RoleHelper.HasPermissions(roles);
            if (!hasRole)
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


        [HttpPost("validateStockDocument"), Authorize("VALIDATE_TRANSFER_MOVEMENT")]
        public ResponseData ValidateStockDocument([FromBody] int id)
        {
            return new ResponseData
            {
                objectData = _serviceStockDocument.ValidateDocument(id, userMail),
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = 1
            };
        }

        [HttpPost("validateStoragekDocument"), Authorize("VALIDATE_SHELFS_AND_STORAGES")]
        public ResponseData ValidatestorageMovementDocument([FromBody] int id)
        {

            return new ResponseData
            {
                objectData = _serviceStockDocument.ValidatestorageMovementDocument(id, userMail),
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = 1
            };
        }

        [HttpPost("transfertValidateStockDocument"), Authorize("TRANSFER_TRANSFER_MOVEMENT,TRANSFER_SHELFS_AND_STORAGES")]
        public ResponseData TransfertValidateStockDocument([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            string documentTypeCode = GetDocumentTypeCode(int.Parse(objectToSave.model, CultureInfo.InvariantCulture));
            bool hasRole = RoleHelper.HasPermission("TRANSFER_TRANSFER_MOVEMENT");
            bool hasRole2 = RoleHelper.HasPermission("ADD-StockMovementLineEcomm");
            bool hasTransferShelfAndStoragesRole = RoleHelper.HasPermission("TRANSFER_SHELFS_AND_STORAGES");
            if (!hasRole && !hasRole2 && !hasTransferShelfAndStoragesRole)
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


        [HttpPost("receiveValidateStockDocument"), Authorize("RECIEVE_TRANSFER_MOVEMENT,RECEIVE_SHELFS_AND_STORAGES")]
        public ResponseData ReceiveValidateStockDocument([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            ResponseData result = new ResponseData
            {
                objectData = _serviceStockDocument.ReceiveValidateStockDocument(int.Parse(objectToSave.model, CultureInfo.InvariantCulture)),
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = 1
            };
            return result;
        }


        [HttpPost("insertStockDocumentInRealTime"), Authorize("ADD_TRANSFER_MOVEMENT,ADD_SHELFS_AND_STORAGES,SHOW_SHELFS_AND_STORAGES,UPDATE_SHELFS_AND_STORAGES")]
        public ResponseData InsertStockDocumentInRealTime(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            if (objectSaved == null)
            {
                throw new ArgumentNullException(nameof(objectSaved));
            }
            StockDocumentViewModel instanceType = JsonConvert.DeserializeObject<StockDocumentViewModel>(objectSaved.model.ToString());
            GetUserMail();
            ResponseData result = new ResponseData
            {
                customStatusCode = instanceType.Id == NumberConstant.Zero ? CustomStatusCode.AddSuccessfull : CustomStatusCode.UpdateSuccessfull,
                objectData = _serviceStockDocument.AddModelInRealTime(instanceType, objectSaved.EntityAxisValues, userMail),
                flag = 1
            };
            return result;
        }

        [HttpPost("insertStockDocumentLineInRealTime"), Authorize("ADD_TRANSFER_MOVEMENT,UPDATE_TRANSFER_MOVEMENT,ADD_SHELFS_AND_STORAGES,UPDATE_SHELFS_AND_STORAGES")]
        public ResponseData InsertStockDocumentLineInRealTime([FromBody] StockDocumentLineViewModel objectSaved)
        {
            var obj = _serviceStockDocument.AddLineInRealTime(objectSaved);
            return new ResponseData
            {
                customStatusCode = CustomStatusCode.AddSuccessfull,
                objectData = obj,
                flag = 1
            };
        }



        [HttpPost("deleteLineInRealTime"), Authorize("ADD_TRANSFER_MOVEMENT,UPDATE_TRANSFER_MOVEMENT,ADD_SHELFS_AND_STORAGES,UPDATE_SHELFS_AND_STORAGES")]
        public ResponseData DeleteLineInRealTime([FromBody] int id)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var obj = _serviceStockDocument.DeleteLineInRealTime(id);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.DeleteSuccessfull;
                result.objectData = obj;

            }
            return result;
        }

        [HttpPost("getStockDocumentWithStockDocumentLine"), Authorize("ADD_TRANSFER_MOVEMENT,UPDATE_TRANSFER_MOVEMENT,SHOW_TRANSFER_MOVEMENT,SHOW_SHELFS_AND_STORAGES,ADD_SHELFS_AND_STORAGES,UPDATE_SHELFS_AND_STORAGES")]
        public ResponseData GetStockDocumentWithStockDocumentLine([FromBody] DocumentLinesWithPagingViewModel documentLinesWithPagingViewModel)

        {

            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            var dataSourceResult = _service.GetStockDocumentWithStockDocumentLine(documentLinesWithPagingViewModel, out int total);
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
        [HttpPost("getModelByCondition"), Authorize("SHOW_TRANSFER_MOVEMENT,UPDATE_TRANSFER_MOVEMENT,ADD_TRANSFER_MOVEMENT,SHOW_SHELFS_AND_STORAGES,UPDATE_SHELFS_AND_STORAGES")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }
        [HttpDelete("delete/{id}"), Authorize("DELETE_TRANSFER_MOVEMENT,DELETE_INVENTORY_MOVEMENT,DELETE_SHELFS_AND_STORAGES")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_INVENTORY_MOVEMENT,LIST_TRANSFER_MOVEMENT")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
        [HttpPost("downloadJasperDocumentReport"), Authorize("PRINT_INVENTORY_MOVEMENT,PRINT_TRANSFER_MOVEMENT")]
        public override Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            return base.DownloadJasperDocumentReport(data);
        }

        [HttpPost("getStockDocumentLineByIdItem"), Authorize("SHOW_TRANSFER_MOVEMENT")]
        public ResponseData GetStockDocumentLineByIdItem([FromBody] PredicateFormatViewModel predicateModel)
        {
            var data = _serviceStockDocumentLine.GetStockDocumentLineByIdItem(predicateModel);
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = data.data,
                    total = data.total
                },
                flag = 2,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
            };
            return result;

        }
       } 
    }
