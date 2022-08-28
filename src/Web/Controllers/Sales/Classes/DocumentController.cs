using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Services.Reporting.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Ecommerce;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using ViewModels.DTO.SameClasse;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Treasury;
using ViewModels.DTO.Utils;
using Web.Controllers.CommonControllers;
using Web.Controllers.GenericController;
using Web.Controllers.Sales.Interfaces;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/document")]
    public class DocumentController : BaseController, IDocumentController
    {
        const string idConst = "Id";
        const string idDocument = "IdDocument";
        const string status = "Status";
        const string listOfIdDocumentConst = "ListOfIdDocument";
        const string documentTypeCodeConst = "DocumentTypeCode";
        const StringComparison stringComparison = StringComparison.InvariantCultureIgnoreCase;

        private readonly IServiceDocument _serviceDocument;
        private readonly IRepository<Settlement> _settlementRepo;
        private readonly IServiceMessageDocument _msgService;
        private readonly IServiceJasperReporting _serviceJasperReporting;
        private readonly IServiceDocumentLine _serviceDocumentLine;
        private readonly SmtpSettings _smtpSettings;

        private const string jsonHeaderType = "application/json";
        private const string reportApi = "api/customReports/downloadSalesInvoice";
        private const string dailySalesReportApi = "api/customReports/downloadDailySalesReport";
        private const string reportPrintApi = "api/customReports/printSalesInvoice";
        private const string reportMultiPrintApi = "api/customReports/multiPrintSalesInvoice";
        private const string reportDownloadPurchaseDocApi = "api/customReports/downloadPurchaseDoc";
        //private const string reportApi = "api/webreports/downloadSalesInvoice";
        private const string dateFormat = "yyyyMMddHHmmssfffffff";
        private const string connectionString = "connectionString";
        private readonly IServiceUser _userService;

        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public DocumentController(IServiceDocumentLine serviceDocumentLine, IServiceProvider serviceProvider, ILogger<DocumentController> logger, IServiceDocument serviceDocument,
             IServiceMessageDocument msgService, IServiceJasperReporting serviceJasperReporting, IOptions<SmtpSettings> smtpSettings, IOptions<AppSettings> appSettings, IOptions<PrinterSettings> printerSettings,
             IRepository<Settlement> settlementRepo, IServiceUser userService) : base(serviceProvider, logger, appSettings, printerSettings)
        {
            _service = serviceDocument;
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceDocument = serviceDocument;
            _msgService = msgService;
            _smtpSettings = smtpSettings.Value;
            _settlementRepo = settlementRepo;
            _serviceJasperReporting = serviceJasperReporting;
            _settlementRepo = settlementRepo;
            _serviceDocumentLine = serviceDocumentLine;
            _userService = userService;
        }

        [HttpPost("getModelByConditionDocument"), Authorize("ADD_DELIVERY_SALES,UPDATE_DELIVERY_SALES,SHOW_DELIVERY_SALES")]
        public new ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            string documentTypeCode = predicate.Filter.FirstOrDefault(p => string.Compare(p.Prop, documentTypeCodeConst, stringComparison) == 0).Value.ToString();
            List<string> actions = new List<string> { AutorizationActionConstants.AuthorizationList };
            bool hasRole = RoleHelper.hasDocumentPermission(actions, documentTypeCode);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            return new ResponseData
            {
                objectData = _serviceDocument.FindModelBy(predicate).FirstOrDefault(),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
        }

        [HttpPost("getDataSourcePredicateDocument"), Authorize("LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES,LIST_FINANCIAL_ASSET_SALES," +
            "LIST_ORDER_QUOTATION_PURCHASE,LIST_FINAL_ORDER_PURCHASE,LIST_RECEIPT_PURCHASE,LIST_INVOICE_PURCHASE,LIST_ASSET_PURCHASE,LIST_ADMISSION_VOUCHERS,LIST_EXIT_VOUCHERS")]
        public ResponseData GetDataSourcePredicateDocument([FromBody] PredicateFormatViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceDocument.FindDocumentList(model);

            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpPost("executeAllCustomerInvoicesGenereation")]
        public void ExecuteAllCustomerInvoicesGenereation()
        {
            ResponseData result = new ResponseData();
            _serviceDocument.GenerateAllCustomerInvoices(null);

        }

        [HttpPost("checkInvoiceErrors")]
        public ResponseData CheckInvoiceErrors()
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.CheckInvoiceErrors()
            };
            return result;
        }


        [HttpGet("getDocumentById/{id}"), Authorize("SHOW_INVOICE_SALES,UPDATE_INVOICE_SALES,ADD_INVOICE_SALES")]
        public ResponseData GetDocumentById(int id)
        {
            ResponseData result = base.GetById(id);
            DocumentViewModel documentViewModel = (DocumentViewModel)result.objectData;
            string documentTypeCode = documentViewModel.DocumentTypeCode;
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentTypeCode, AutorizationActionConstants.AuthorizationShow);

            return (hasRole) ? result : new ResponseData
            {
                customStatusCode = CustomStatusCode.Unauthorized
            };
        }

        [HttpDelete("deleteDocument/{id}"), Authorize("DELETE_PURCHASE_REQUEST,DELETE_ORDER_QUOTATION_PURCHASE,DELETE_FINANCIAL_ASSET_SALES,DELETE_INVOICE_ASSET_SALES,DELETE_INVOICE_PURCHASE, SHOW_UPDATE_QUOTATION_PRICE_REQUEST," +
            "DELETE_ASSET_PURCHASE,DELETE_QUOTATION_SALES,DELETE_RECEIPT_PURCHASE,DELETE_FINAL_ORDER_PURCHASE,DELETE_ORDER_SALES,DELETE_ASSET_SALES,DELETE_INVOICE_SALES,DELETE_ADMISSION_VOUCHERS,DELETE_EXIT_VOUCHERS," +
            "DELETE_DELIVERY_SALES,GENERATE_BILLING_SESSION_INVOICES")]
        public ResponseData DeleteDocument(int id)
        {
            return base.Delete(id);
        }

        [HttpPost("insert_Document"), Authorize("ADD_DOCUMENT")]
        public ResponseData PostDocumentWithoutFiles([FromBody] ObjectToSaveViewModel objectToSave)
        {
            ResponseData result = new ResponseData();
            if (objectToSave != null)
            {
                DocumentViewModel documentViewModel = JsonConvert.DeserializeObject<DocumentViewModel>(objectToSave.model.ToString());
                bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentViewModel.DocumentTypeCode, AutorizationActionConstants.AuthorizationAdd);
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                else
                {
                    GetUserMail();
                    var data = _serviceDocument.AddDocument(null, documentViewModel, userMail, objectToSave.EntityAxisValues);
                    result.customStatusCode = CustomStatusCode.AddSuccessfull;
                    result.objectData = data;
                    result.flag = 1;
                }
            }
            return result;
        }
        [HttpPost("insertDocument")]
        public ResponseData PostDocument(IList<IFormFile> files, ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ResponseData result = new ResponseData();
            ObjectToSaveViewModel objectToSave = (objectJsonToSave != null) ?
                JsonConvert.DeserializeObject<ObjectToSaveViewModel>(objectJsonToSave) : objectSaved;
            if (objectToSave.model != null)
            {
                DocumentViewModel instanceType = JsonConvert.DeserializeObject<DocumentViewModel>(objectToSave.model.ToString());
                bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(instanceType.DocumentTypeCode, AutorizationActionConstants.AuthorizationAdd);
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                else
                {
                    GetUserMail();

                    var data = _serviceDocument.AddDocument(files, instanceType, userMail, objectToSave.EntityAxisValues);
                    result.customStatusCode = CustomStatusCode.AddSuccessfull;
                    result.objectData = data;
                    result.flag = 1;
                }
            }
            return result;

        }

        [HttpPut("updateDocumentAssociated")]
        public ResponseData UpdateDocumentAssociated([FromBody] DocumentViewModel document)
        {
            ResponseData result = new ResponseData();
            if (document == null)
            {
                throw new ArgumentNullException(nameof(document));
            }
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(document.DocumentTypeCode, AutorizationActionConstants.AuthorizationValidate);
            if (hasRole)
            {
                GetUserMail();
                _serviceDocument.UpdateIdDocumentAssociated(document);
                result.objectData = document;
            }
            return result;
        }


        [HttpPut("update_Document")]
        public ResponseData PutDocumentWithoutFiles([FromBody] ObjectToSaveViewModel objectSaved)
        {
            return PutDocument(null, objectSaved, null);
        }
        [HttpPut("updateDocument")]
        public ResponseData PutDocument(IList<IFormFile> files, ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ResponseData result = new ResponseData();
            ObjectToSaveViewModel objectToSave;
            if (objectJsonToSave != null)
            {
                objectToSave = JsonConvert.DeserializeObject<ObjectToSaveViewModel>(objectJsonToSave);
            }
            else
            {
                objectToSave = objectSaved;
            }

            if (objectToSave.model != null)
            {
                DocumentViewModel instanceType = JsonConvert.DeserializeObject<DocumentViewModel>(objectToSave.model.ToString());
                bool hasRole = RoleHelper.hasDocumentPermission(new List<string> { AutorizationActionConstants.AuthorizationUpdate }, instanceType.DocumentTypeCode);
                if (!hasRole)
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
                else
                {
                    GetUserMail();
                    result.objectData = _serviceDocument.UpdateDocument(files, instanceType, objectToSave.EntityAxisValues, userMail);
                    result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
                    result.flag = 1;
                }
            }
            return result;
        }
        [HttpPost("validate"), Authorize("VALIDATE_ORDER_QUOTATION_PURCHASE,VALIDATE_FINANCIAL_ASSET_SALES,VALIDATE_INVOICE_ASSET_SALES,VALIDATE_FINAL_ORDER_PURCHASE,VALIDATE_INVOICE_PURCHASE,VALIDATE_ASSET_PURCHASE," +
            "VALIDATE_QUOTATION_SALES,VALIDATE_RECEIPT_PURCHASE,VALIDATE_ORDER_SALES,VALIDATE_ASSET_SALES,VALIDATE_INVOICE_SALES,VALIDATE_DELIVERY_SALES,VALIDATE_ADMISSION_VOUCHERS,VALIDATE_EXIT_VOUCHERS")]
        public ResponseData ValidateDocument([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            GetUserMail();
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.ValidateDocument(int.Parse(objectToSave.model, CultureInfo.InvariantCulture), userMail),
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = 1
            };
            return result;

        }

        [HttpPost("checkAndChangeDocumentToPrinted")]
        public ResponseData CheckAndChangeDocumentToPrinted([FromBody] int documentId)
        {
            DocumentViewModel documentToCheck = _serviceDocument.GetModelAsNoTracked(x => x.Id == documentId);
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentToCheck.DocumentTypeCode, AutorizationActionConstants.AuthorizationValidate);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                GetUserMail();
                ResponseData result = new ResponseData
                {
                    objectData = _serviceDocument.CheckAndChangeDocumentToPrinted(documentToCheck, userMail),
                    flag = 1
                };
                return result;
            }

        }


        [HttpPost("validateOrReject")]
        public ResponseData ValidateOrReject([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            string documentTypeCode = GetDocumentTypeCode(int.Parse(objectToSave.model[idDocument].Value, CultureInfo.InvariantCulture));
            bool hasRole = RoleHelper.hasDocumentPermission(new List<string> { AutorizationActionConstants.AuthorizationValidate, AutorizationActionConstants.AuthorizationRefuse }, documentTypeCode);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }

            GetUserMail();
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.ValidateOrRejectDocument(int.Parse(objectToSave.model[idDocument].Value,
                CultureInfo.InvariantCulture), userMail, int.Parse(objectToSave.model[status].Value,
                CultureInfo.InvariantCulture)),
                customStatusCode = CustomStatusCode.SUCCESS_REJECT,
                flag = 1
            };
            return result;
        }


        [HttpPost("generatePurchaseOrder"), Authorize("GENERATE_ORDER_PURCHASE_REQUEST")]
        public ResponseData GeneratePurchaseOrder([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null || objectToSave.model[listOfIdDocumentConst] == null || objectToSave.model[listOfIdDocumentConst].Count <= 0)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            IList<int> listOfIdDocument = objectToSave.model[listOfIdDocumentConst].ToObject<List<int>>();
            GetUserMail();
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GeneratePurchaseOrder(listOfIdDocument, userMail, _smtpSettings),
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = 1
            };
            return result;
        }

        [HttpPost("generatePriceRequest"), Authorize("GENERATE_PRICE_REQUEST")]
        public ResponseData GeneratePriceRequest([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null || objectToSave.model[listOfIdDocumentConst] == null || objectToSave.model[listOfIdDocumentConst].Count <= 0)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            IList<int> listOfIdDocument = objectToSave.model[listOfIdDocumentConst].ToObject<List<int>>();

            GetUserMail();
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GeneratePriceRequest(listOfIdDocument, userMail, _smtpSettings),
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = 1
            };
            return result;
        }

        [HttpPost("getDocumentList")]
        public virtual ResponseData GetDocumentList([FromBody] PredicateFormatViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            string documentTypeCode = model.Filter.FirstOrDefault(p => string.Compare(p.Prop, documentTypeCodeConst, stringComparison) == 0).Value.ToString();
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentTypeCode, AutorizationActionConstants.AuthorizationList);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                var dataSourceResult = _serviceDocument.GetDocumentList(model);
                ResponseData result = new ResponseData
                {
                    listObject = new ListObject
                    {
                        listData = dataSourceResult.data,
                        total = dataSourceResult.total
                    }
                };
                return result;
            }
        }

        [HttpPost("getRequestList"), Authorize("ADD_PURCHASE_REQUEST")]
        public virtual ResponseData GetRequestList([FromBody] PredicateFormatViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            GetUserMail();
            var dataSourceResult = _serviceDocument.GetDocumentList(model, userMail);
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

        [HttpPost("getItemPrice"), Authorize("ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,ADD_FINAL_ORDER_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE,ADD_INVOICE_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE,UPDATE_QUOTATION_SALES,UPDATE_FINANCIAL_ASSET_SALES," +
            "UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES,UPDATE_ASSET_SALES,UPDATE_INVOICE_SALES,SHOW_UPDATE_QUOTATION_PRICE_REQUEST,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_EXIT_VOUCHERS,UPDATE_ADMISSION_VOUCHERS," +
            "COUNTER_SALES")]
        public ResponseData GetItemPrice([FromBody] ObjectToSaveViewModel objectSaved)
        {
            ItemPriceViewModel itemPriceViewModel = JsonConvert.DeserializeObject<ItemPriceViewModel>(objectSaved.model.itemPrice.ToString());
            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }
            DocumentLineViewModel documentLine = _serviceDocument.GetItemPrice(itemPriceViewModel);
            ResponseData result = new ResponseData
            {
                objectData = documentLine,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
                flag = 1
            };
            return result;
        }
        [HttpPost("getLastBLPriceForItem/{idTiers}"), Authorize("ADD_DELIVERY_SALES,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,COUNTER_SALES")]
        public ResponseData getLastBLPriceForItem([FromBody] int idItem, int idTiers)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetLastBLPriceForItem(idItem, idTiers),
                flag = 1
            };
            return result;
        }

        [HttpPost("getItemDetails"), Authorize("FABRICATION_PERMISSION,ADD_PURCHASE_REQUEST,UPDATE_PURCHASE_REQUEST")]
        public ResponseData GetItemDetails([FromBody] int idItem)
        {
            DocumentLineViewModel documentLine = _serviceDocument.GetItemDetails(idItem);
            ResponseData result = new ResponseData
            {
                objectData = documentLine,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpPost("getDocumentLineUnitPrice")]
        public ResponseData GetDocumentLineUnitPrice([FromBody] DocumentLineUnitPriceViewModel documentLineUnitPrice)
        {
            if (documentLineUnitPrice == null)
            {
                throw new ArgumentNullException(nameof(documentLineUnitPrice));
            }
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentLineUnitPrice.DocumentTypeCode, AutorizationActionConstants.AuthorizationAdd);
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
                    objectData = _serviceDocument.GetDocumentLineHtPrice(documentLineUnitPrice),
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
                    flag = 1
                };
                return result;
            }
        }

        [HttpPost("getDocumentLineDiscountRate")]
        public ResponseData GetDocumentLineDiscountRate([FromBody] DocumentLineUnitPriceViewModel documentLineUnitPrice)
        {
            if (documentLineUnitPrice == null)
            {
                throw new ArgumentNullException(nameof(documentLineUnitPrice));
            }
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentLineUnitPrice.DocumentTypeCode, AutorizationActionConstants.AuthorizationAdd);
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
                    objectData = _serviceDocument.GetDocumentLineDiscountRate(documentLineUnitPrice),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
        }

        [HttpPost("getDocumentLineValues")]
        public ResponseData GetDocumentLineValues([FromBody] ItemPriceViewModel itemPriceViewModel)
        {
            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(itemPriceViewModel.DocumentType, AutorizationActionConstants.AuthorizationAdd);
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
                    objectData = _serviceDocument.GetDocumentLineValues(itemPriceViewModel),
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
                    flag = 1
                };
                return result;
            }
        }

        [HttpPost("checkRealAndProvisionalStock"), Authorize("UPDATE_VALID_DELIVERY_SALES,UPDATE_DELIVERY_SALES,ADD_DELIVERY_SALES,COUNTER_SALES")]
        public ResponseData CheckRealAndProvisionalStock([FromBody] ObjectToSaveViewModel objectSaved)
        {
            ItemPriceViewModel itemPriceViewModel = JsonConvert.DeserializeObject<ItemPriceViewModel>(objectSaved.model.itemPrice.ToString());
            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.IsProvisionalStock(itemPriceViewModel),
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
                flag = 1
            };
            return result;

        }
        [HttpPost("getDocumentTotalPrice")]
        public ResponseData GetDocumentTotalPrice([FromBody] ReduisDocumentViewModel reduisDocumentViewModel)
        {
            if (reduisDocumentViewModel == null)
            {
                throw new ArgumentNullException(nameof(reduisDocumentViewModel));
            }
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(reduisDocumentViewModel.DocumentType, AutorizationActionConstants.AuthorizationAdd);
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
                    objectData = _serviceDocument.GetDocumentTotalPrice(reduisDocumentViewModel),
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
                    flag = 1
                };
                return result;
            }
        }




        [HttpGet("getDocumentWithDocumentLine/{id}"), Authorize("ADD_DELIVERY_SALES,UPDATE_DELIVERY_SALES,ADD_ORDER_QUOTATION_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE," +
            "SHOW_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE,SHOW_ASSET_PURCHASE,SHOW_INVOICE_PURCHASE,UPDATE_RECEIPT_PURCHASE,ADD_RECEIPT_PURCHASE," +
            "SHOW_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES,ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_QUOTATION_SALES,UPDATE_ORDER_SALES,UPDATE_INVOICE_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,SHOW_FINAL_ORDER_PURCHASE,SHOW_QUOTATION_SALES,SHOW_FINANCIAL_ASSET_SALES,SHOW_INVOICE_ASSET_SALES,ADD_INVOICE_ASSET_SALES," +
            "UPDATE_INVOICE_ASSET_SALES,SHOW_ORDER_SALES,UPDATE_VALID_ORDER_SALES,SHOW_ASSET_SALES,UPDATE_VALID_ASSET_SALES,SHOW_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,SHOW_ADMISSION_VOUCHERS," +
            "SHOW_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,ADD_EXIT_VOUCHERS,UPDATE_EXIT_VOUCHERS,SHOW_EXIT_VOUCHERS,SHOW_PURCHASE_REQUEST,UPDATE_PURCHASE_REQUEST,COUNTER_SALES")]
        public virtual ResponseData GetDocumentWithDocumentLine(int id)
        {
            GetUserMail();
            
            DocumentViewModel documentViewModel = _serviceDocument.FindDocumentWithDocumentLine(id, userMail);
            if (documentViewModel == null)
            {
                return new ResponseData
                {
                    objectData = CustomStatusCode.NotFound
                };
            }
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = documentViewModel,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpGet("getShelfAndStorageOfItemInWarehouse/{idItem}/{idWarehouse}")]
        public virtual ResponseData GetShelfAndStorageOfItemInWarehouse(int idItem, int idWarehouse)
        {
            string shelfAndStorage = _serviceDocument.GetShelfAndStorageOfItemInWarehouse(idItem, idWarehouse);
            ResponseData result = new ResponseData
            {
                objectData = shelfAndStorage
            };
            return result;
        }

        [HttpPost("getRate")]
        public ResponseData GetRate([FromBody] dynamic model)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _service.GetRate(model);
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
            }
            return result;
        }
        [HttpPost("send"), Authorize("ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,VALIDATE_ORDER_QUOTATION_PURCHASE,VALIDATE_FINAL_ORDER_PURCHASE," +
            "UPDATE_INVOICE_PURCHASE,SHOW_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE,ADD_ASSET_PURCHASE,ADD_QUOTATION_SALES,UPDATE_QUOTATION_SALES,SHOW_QUOTATION_SALES,ADD_RECEIPT_PURCHASE," +
            "UPDATE_RECEIPT_PURCHASE,VALIDATE_RECEIPT_PURCHASE,ADD_ORDER_SALES,UPDATE_ORDER_SALES,UPDATE_ASSET_SALES,ADD_ASSET_SALES,VALIDATE_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_INVOICE_SALES,VALIDATE_DELIVERY_SALES," +
            "VALIDATE_ADMISSION_VOUCHERS,VALIDATE_EXIT_VOUCHERS,ADD_ADMISSION_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_EXIT_VOUCHERS")]
        public void BroadCastMail([FromBody] MailBrodcastConfigurationViewModel configModel)
        {
            _msgService.ConfigureMail(configModel, _smtpSettings);
        }



        /// <summary>
        /// get document type code from document id
        /// </summary>
        /// <param name="id">document id</param>
        /// <returns>document type code</returns>
        private string GetDocumentTypeCode(int id)
        {
            DocumentViewModel document = _serviceDocument.GetModelAsNoTracked(x => x.Id == id);
            if (document == null)
            {
                throw new CustomException(CustomStatusCode.NotFound);
            }
            return document.DocumentTypeCode;
        }

        [HttpPut("GetDocumentLinesToImport")]
        public List<DocumentLineViewModel> GetDocumentLinesToImport([FromBody] ReduisDocumentViewModel ReduisDocument)
        {
            List<DocumentLineViewModel> documentlines = new List<DocumentLineViewModel>();
            if (ReduisDocument != null)
            {
                documentlines = _serviceDocument.GetDocumentLinesWithDocument(ReduisDocument);

            }
            return documentlines;
        }


        [HttpPost("uploadFileDocument")]
        public ResponseData UploadFileDocument([FromBody] DocumentUpload documentUpload)
        {
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentUpload.DocumentType, AutorizationActionConstants.AuthorizationAdd);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                return new ResponseData
                {
                    objectData = UploadFile(documentUpload.fileInfoViewModel),
                    customStatusCode = CustomStatusCode.GetSuccessfull,
                    flag = 1,
                };

            }
        }

        [HttpPost("downloadZipFileDocument")]
        public ResponseData DownloadZipFileDocument([FromBody] int[] model)
        {
            return new ResponseData
            {
                objectData = DownloadDocs(model),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1,
            };
        }

        /// <summary>
        /// Get list of PurchaseOrders that all its line has never been imported and list of balances 
        /// </summary>
        /// <param name="reduisDocument"></param>
        /// <returns></returns>
        [HttpPost("getDocumentsWithBalances"), Authorize("LIST_ORDER_QUOTATION_PURCHASE,LIST_INVOICE_PURCHASE,LIST_FINAL_ORDER_PURCHASE,LIST_ASSET_SALES,LIST_QUOTATION_SALES,LIST_INVOICE_SALES," +
            "LIST_DELIVERY_SALES,LIST_ORDER_SALES,COUNTER_SALES")]
        public virtual ResponseData GetDocumentsWithBalances([FromBody] ReduisDocumentViewModel reduisDocument)
        {
            ImportDocumentBalancesViewModel importPurchaseOrderObject = _serviceDocument.GetDocumentsWithBalances(reduisDocument);
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = importPurchaseOrderObject,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        /// <summary>
        /// Get list of PurchaseOrders that all its line has never been imported and list of balances 
        /// </summary>
        /// <param name="reduisDocument"></param>
        /// <returns></returns>
        [HttpPost("getItemHistoryMovement"), Authorize("HISTORY_ITEM,LIST_QUICK_SALES,ADD_PROVISIONING,UPDATE_PROVISIONING")]
        public virtual ResponseData GetItemHistoryMovement([FromBody] ItemHistoryViewModel itemHistoryViewModel)
        {
            ItemHistoryViewModel resultBody = _serviceDocument.GetMovementHistoryRelatedToItem(itemHistoryViewModel);
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = resultBody,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }


        [HttpPost("saveCurrentDocumentLine"), Authorize("ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,SHOW_UPDATE_QUOTATION_PRICE_REQUEST," +
            "UPDATE_ADMISSION_VOUCHERS,UPDATE_EXIT_VOUCHERS,COUNTER_SALES")]
        public virtual ResponseData SaveCurrentDocumentLine([FromBody] ItemPriceViewModel itemPrice)
        {
            GetUserMail();
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDocument.InsertUpdateDocumentLine(itemPrice, userMail),
                customStatusCode = itemPrice.DocumentLineViewModel.IsDeleted ? CustomStatusCode.LineDeletedSuccessfully : CustomStatusCode.LineAddedsuccessfully
            };

            return result;
        }

        [HttpPost("saveCurrentBSDocumentLine")]
        public virtual ResponseData SaveCurrentBSDocumentLine([FromBody] ItemPriceViewModel itemPriceViewModel)
        {
            List<string> actions = new List<string> { AutorizationActionConstants.AuthorizationAdd, AutorizationActionConstants.AuthorizationUpdate };
            bool hasRole = RoleHelper.hasDocumentPermission(actions, itemPriceViewModel.DocumentType);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                ResponseData result = new ResponseData();
                GetUserMail();
                result.objectData = _serviceDocument.InsertUpdateBSDocumentLine(itemPriceViewModel);

                return result;
            }
        }


        [HttpPost("saveCurrentDocument"), Authorize("ADD_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES,ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES," +
            "ADD_FINAL_ORDER_PURCHASE,ADD_INVOICE_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE,UPDATE_QUOTATION_SALES,IMPORT_FINAL_ORDER_PURCHASE,ADD_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_VALID_ORDER_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,ADD_PURCHASE_REQUEST,ADD_INVOICE, COUNTER_SALES")]
        public virtual ResponseData SaveCurrentDocument([FromBody] ObjectToSaveViewModel objectSaved)
        {
            DocumentViewModel document =
                JsonConvert.DeserializeObject<DocumentViewModel>(objectSaved.model.document.ToString());
            GetUserMail();
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.AddDocumentInRealTime(null, document, userMail, new List<EntityAxisValuesViewModel>()),
                customStatusCode = CustomStatusCode.AddSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }

        [HttpPost("updateDocumentAmounts")]
        public virtual ResponseData UpdateDocument([FromBody] int id)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _serviceDocument.UpdateDocumentAmounts(id, userMail);
            return result;
        }

        [HttpPost("getDocumentAmounts"), Authorize("SHOW_DELIVERY_SALES, ADD_ORDER_QUOTATION_PURCHASE, UPDATE_ORDER_QUOTATION_PURCHASE, ADD_QUOTATION_SALES, ADD_ORDER_SALES, ADD_DELIVERY_SALES, ADD_INVOICE_SALES, ADD_ASSET_SALES, " +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,COUNTER_SALES")]
        public virtual ResponseData GetDocumentInRealTime([FromBody] int id)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _serviceDocument.GetDocumentAmounts(id, userMail);
            return result;
        }


        [HttpPost("updateDocumentFields"), Authorize("UPDATE_VALID_ORDER_SALES,ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,SHOW_FINANCIAL_ASSET_SALES,UPDATE_ADMISSION_VOUCHERS,UPDATE_EXIT_VOUCHERS")]
        public virtual ResponseData UpdateDocumentFields([FromBody] ObjectToSaveViewModel objectToSave)
        {
            DocumentViewModel document = JsonConvert.DeserializeObject<DocumentViewModel>(objectToSave.model.ToString());
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _serviceDocument.UpdateDocumentFields(document, userMail);
            return result;
        }

        [HttpPost("updateDocumentAfterImport"), Authorize("IMPORT_ORDER_PURCHASE,IMPORT_INVOICE_PURCHASE,IMPORT_FINAL_ORDER_PURCHASE,IMPORT_ASSET_SALES,IMPORT_QUOTATION_SALES,IMPORT_INVOICE_SALES," +
            "IMPORT_DELIVERY_SALES,IMPORT_ORDER_SALES,COUNTER_SALES")]
        public virtual ResponseData UpdateDocumentAfterImport([FromBody] ImportDocumentsViewModel importDocumentsViewModel)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _serviceDocument.ImportDocuments(importDocumentsViewModel, userMail);
            return result;
        }
        [HttpPost("fusionBl"), Authorize("FUSION_DELIVERY_SALES")]
        public virtual ResponseData FusionBl([FromBody] ImportDocumentsViewModel importDocumentsViewModel)
        {
            ResponseData result = new ResponseData();
            _serviceDocument.FusionBl(importDocumentsViewModel);
            GetUserMail();
            return result;
        }

        [HttpPost("updateDocumentBSAfterImport")]
        public virtual ResponseData UpdateDocumentBSAfterImport([FromBody] ImportDocumentsBSViewModel importDocumentsViewModel)
        {
            ResponseData result = new ResponseData();
            List<string> actions = new List<string> { AutorizationActionConstants.AuthorizationAdd, AutorizationActionConstants.AuthorizationUpdate };
            bool hasRole = RoleHelper.hasDocumentPermission(actions, DocumentEnumerator.BS);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                GetUserMail();
                _serviceDocument.ImportDocumentsBS(importDocumentsViewModel);
                result.objectData = true;
            }
            return result;
        }

        [HttpPost("updateDocumentLineRealTime")]
        public virtual ResponseData UpdateDocumentLineRealTime([FromBody] ItemPriceViewModel itemPrice)
        {
            ResponseData result = new ResponseData();
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(itemPrice.DocumentType, AutorizationActionConstants.AuthorizationList, itemPrice.IsRestaurn);

            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                GetUserMail();
                _serviceDocument.InsertUpdateDocumentLine(itemPrice, userMail);
            }
            return result;
        }

        [HttpPost("saveBalances")]
        public virtual ResponseData SaveBalances([FromBody] DocumentWithDocumentLineViewModel documentLineViewModelList)
        {
            ResponseData result = new ResponseData();
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentLineViewModelList.DocumentType, AutorizationActionConstants.AuthorizationList);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {

                result.objectData = _serviceDocument.SaveBalances(documentLineViewModelList);
            }
            return result;
        }

        [HttpPost("saveUpdateExpenseLine"), Authorize("UPDATE_RECEIPT_PURCHASE,ADD_RECEIPT_PURCHASE")]
        public virtual ResponseData SaveUpdateExpenseLine([FromBody] DocumentExpenseLineViewModel expenseLine)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _serviceDocument.SaveUpdateExpenseLine(expenseLine, userMail);
            return result;
        }


        [HttpPost("updateDocumentAfterImportFile")]
        public virtual ResponseData UpdateDocumentAfterImportFile([FromBody] DocumentViewModel document)
        {
            ResponseData result = new ResponseData();
            bool hasRole = RoleHelper.hasDocumentPermission(new List<string> { AutorizationActionConstants.AuthorizationAdd, AutorizationActionConstants.AuthorizationUpdate, AutorizationActionConstants.AuthorizationUpdateValid },
                                                            document.DocumentTypeCode);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                DocumentViewModel oldDocument = _serviceDocument.GetDocumentById(document.Id);
                oldDocument.FilesInfos = document.FilesInfos;
                _serviceDocument.ManageFileInRealTime(oldDocument);


                return result;
            }
        }

        [HttpPost("getDocumentsIdsWithCondition")]
        public ResponseData GetDocumentsIdsWithCondition([FromBody] PredicateFormatViewModel predicate)
        {
            string documentTypeCode = predicate.Filter.FirstOrDefault(p => string.Compare(p.Prop, documentTypeCodeConst, stringComparison) == 0).Value.ToString();
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentTypeCode, AutorizationActionConstants.AuthorizationList);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            return new ResponseData
            {
                objectData = _serviceDocument.GetDocumentsIdsWithCondition(predicate),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
        }

        [HttpGet("generateInvoiceFromBillingSession/{idBillingSession}")]
        public ResponseData GenerateInvoiceFromBillingSession(int idBillingSession)
        {
            bool hasSalesInvoiceRole = SpecificAuthorizationCheck.DocumentAuthorization(DocumentEnumerator.SalesInvoice, AutorizationActionConstants.AuthorizationAdd);
            if (!hasSalesInvoiceRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                GetUserMail();
                ResponseData result = new ResponseData
                {
                    flag = 1,
                    objectData = _serviceDocument.GenerateInvoiceFromBillingSessionAsync(idBillingSession),
                    customStatusCode = CustomStatusCode.GetByIdSuccessfull
                };
                return result;
            }
        }

        [HttpPost("calculateCostPrice"), Authorize("COST_PRICE_PURCHASE,VALIDATE_RECEIPT_PURCHASE")]
        public ResponseData CalculateCostPrice([FromBody] InputToCalculateCoefficientOfPriceCostViewModel inputToCalculatePriceCost)
        {
            if (inputToCalculatePriceCost == null)
            {
                throw new ArgumentNullException(nameof(inputToCalculatePriceCost));
            }
            GetUserMail();
            ResponseData result = new ResponseData
            {
                flag = 0,
                objectData = _serviceDocument.CalculateCostPrice(inputToCalculatePriceCost, userMail)
            };
            return result;
        }
        [HttpPost("getCostPriceWithPaging"), Authorize("COST_PRICE_PURCHASE")]
        public ResponseData GetCostPriceWithPaging([FromBody] DocumentLinesWithPagingViewModel getCostPriceWithPaging)
        {
            if (getCostPriceWithPaging == null)
            {
                throw new ArgumentNullException(nameof(getCostPriceWithPaging));
            }
            var dataSourceResult = _serviceDocument.GetCostPriceWithPaging(getCostPriceWithPaging, out int total);
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

        #region Accounting

        [HttpPost("getAccountingDocument"), Authorize("GENERATE_DOCUMENT_ACCOUNT_FROM_DOCUMENT")]
        public ResponseData GetAccountingDocument([FromBody] PredicateFormatViewModel imoptedDocument)
        {
            if (imoptedDocument == null)
            {
                throw new ArgumentNullException(nameof(imoptedDocument));
            }
            var dataSet = _serviceDocument.GetAccountingDocument(imoptedDocument, out int total);
            ResponseData result = new ResponseData
            {
                flag = 2,
                listObject = new ListObject
                {
                    listData = dataSet,
                    total = total,
                },
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }

        [HttpPost("accountDocument"), Authorize("IMPORT_ACCOUNTING_DOCUMENTS")]
        public ResponseData AccountDocument([FromBody] int idDocument)
        {
            var documentViewModel = _serviceDocument.GetModelAsNoTracked(x => x.Id == idDocument);
            if (documentViewModel == null)
            {
                throw new ArgumentNullException(nameof(documentViewModel));
            }

            _serviceDocument.AccountDocument(documentViewModel);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;

        }

        [HttpPost("accountDocuments"), Authorize("IMPORT_ACCOUNTING_DOCUME8NTS")]
        public ResponseData AccountDocuments([FromBody] List<int> idDocuments)
        {
            IList<DocumentViewModel> documentViewModels = _serviceDocument.FindModelsByNoTracked(m => idDocuments.Contains(m.Id)).ToList();
            if (documentViewModels == null || !documentViewModels.Any())
            {
                throw new ArgumentNullException(nameof(documentViewModels));
            }

            GetUserMail();
            _serviceDocument.AccountDocuments(documentViewModels, userMail);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;

        }

        [HttpPost("unaccountDocument"), Authorize("IMPORT_ACCOUNTING_DOCUMENTS")]
        public ResponseData UnaccountedDocument([FromBody] int idDocument)
        {
            var documentViewModel = _serviceDocument.GetModelAsNoTracked(x => x.Id == idDocument);
            if (documentViewModel == null)
            {
                throw new ArgumentNullException(nameof(documentViewModel));
            }

            _serviceDocument.UnaccountedDocument(documentViewModel);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;

        }


        [HttpPost("accountSettlement")]
        public ResponseData AccountSettlement([FromBody] int idSettlement)
        {
            var settlementViewModel = _settlementRepo.GetSingleNotTracked(x => x.Id == idSettlement);
            var documentViewModel = _serviceDocument.FindByAsNoTracking(x => x.FinancialCommitment.
                        Where(y => y.SettlementCommitment.Where(z => z.Settlement.Id == idSettlement) != null) != null);
            if (documentViewModel == null)
            {
                throw new ArgumentNullException(nameof(documentViewModel));
            }
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentViewModel.First().DocumentTypeCode, AutorizationActionConstants.AuthorizationAdd);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                _serviceDocument.AccountSettlement(settlementViewModel);
                ResponseData result = new ResponseData
                {
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetSuccessfull
                };
                return result;
            }
        }

        [HttpPost("unaccountSettlement")]
        public ResponseData UnaccountedSettlement([FromBody] int idSettlement)
        {
            var settlementViewModel = _settlementRepo.GetSingleNotTracked(x => x.Id == idSettlement);
            var documentViewModel = _serviceDocument.FindByAsNoTracking(x => x.FinancialCommitment.
                        Where(y => y.SettlementCommitment.Where(z => z.Settlement.Id == idSettlement) != null) != null);
            if (documentViewModel == null)
            {
                throw new ArgumentNullException(nameof(documentViewModel));
            }
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentViewModel.First().DocumentTypeCode, AutorizationActionConstants.AuthorizationAdd);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                _serviceDocument.UnaccountedSettlement(settlementViewModel);
                ResponseData result = new ResponseData
                {
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetSuccessfull
                };
                return result;
            }
        }



        #endregion

        [HttpPost("updatePurchaseRequest")]
        public ResponseData UpdatePurchaseRequest([FromBody] DocumentViewModel document)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.UpdatePurchaseRequest(document)
            };
            return result;
        }

        [HttpPost("getDocumentLinesWithPaging"), Authorize("SHOW_DELIVERY_SALES,ADD_DELIVERY_SALES,UPDATE_DELIVERY_SALES,ADD_ORDER_QUOTATION_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE," +
            "SHOW_ORDER_QUOTATION_PURCHASE,UPDATE_FINAL_ORDER_PURCHASE,UPDATE_RECEIPT_PURCHASE,ADD_RECEIPT_PURCHASE,SHOW_RECEIPT_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_INVOICE_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "SHOW_ASSET_PURCHASE,SHOW_INVOICE_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES,ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_QUOTATION_SALES," +
            "UPDATE_ORDER_SALES,UPDATE_DELIVERY_SALES,UPDATE_INVOICE_SALES,UPDATE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,SHOW_FINAL_ORDER_PURCHASE,SHOW_QUOTATION_SALES," +
            "SHOW_FINANCIAL_ASSET_SALES,SHOW_INVOICE_ASSET_SALES,SHOW_ORDER_SALES,UPDATE_VALID_ORDER_SALES,SHOW_ASSET_SALES,UPDATE_VALID_ASSET_SALES,SHOW_INVOICE_SALES,SHOW_UPDATE_QUOTATION_PRICE_REQUEST," +
            "ADD_ADMISSION_VOUCHERS,UPDATE_ADMISSION_VOUCHERS,SHOW_ADMISSION_VOUCHERS,UPDATE_VALID_DELIVERY_SALES,ADD_EXIT_VOUCHERS,UPDATE_EXIT_VOUCHERS,SHOW_EXIT_VOUCHERS,COUNTER_SALES")]
        public ResponseDataDocumentLine GetDocumentLinesWithPaging([FromBody] DocumentLinesWithPagingViewModel documentLinesWithPagingViewModel)

        {
            GetUserMail();
            var dataSourceResult = _serviceDocument.GetDocumentLinesWithPaging(documentLinesWithPagingViewModel, userMail, out int total);
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

            ResponseDataDocumentLine resultFin = new ResponseDataDocumentLine
            {
                result = result,
                isContainsLines = _serviceDocument.IsDocumentContainsLines(documentLinesWithPagingViewModel.IdDocument)
            };
            return resultFin;

        }

        [HttpPost("getSearchDocumentLineResult")]
        public ResponseData GetSearchDocumentLineResult([FromBody] DocumentLinesWithPagingViewModel documentLinesWithPagingViewModel)

        {
            GetUserMail();
            var dataSourceResult = _serviceDocument.GetDocumentLinesWithPaging(documentLinesWithPagingViewModel, userMail, out int total);
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



        [HttpPost("getBlsForTermBilling"), Authorize("LIST_INVOICE_SALES")]
        public ResponseData GetBlsForTermBilling([FromBody] dynamic model)

        {
            GetUserMail();
            var dataSourceResult = _serviceDocument.GetBlsForTermBilling((DateTime)model.date, true, (int?)model.idTierCategory);
            ResponseData result = new ResponseData
            {
                flag = 2,
                customStatusCode = CustomStatusCode.GetSuccessfull

            };
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            return result;

        }

        [HttpPost("getInvoiceAssetsForTermBilling"), Authorize("LIST_FINANCIAL_ASSET_SALES,LIST_INVOICE_ASSET_SALES")]
        public ResponseData getInvoiceAssetsForTermBilling([FromBody] dynamic model)

        {
            GetUserMail();
            var dataSourceResult = _serviceDocument.GetBlsForTermBilling((DateTime)model.date, false, (int?)model.idTierCategory);
            ResponseData result = new ResponseData
            {
                flag = 2,
                customStatusCode = CustomStatusCode.GetSuccessfull

            };
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            return result;

        }

        [HttpPost("generateTermInvoice"), Authorize("GENERATE_TERM_BILLING")]
        public ResponseData GenerateTermInvoice([FromBody] ObjectToSaveViewModel objectToSave)
        {
            TierSettlementData data = JsonConvert.DeserializeObject<TierSettlementData>(objectToSave.model.ToString());
            List<TierSettelementMode> tierSettelement = data.tierIdList;
            DateTime date = data.date;
            DateTime invoicingDate = data.invoicingDate;
            bool isBl = data.isBl;
            GetUserMail();
            var generatedIds = _serviceDocument.GenerateTermInvoice(tierSettelement, date, invoicingDate, userMail, isBl);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.SuccessValidation,
                objectData = generatedIds
            };
            result.listObject = new ListObject
            {
                listData = generatedIds
            };
            return result;

        }

        [HttpPost("savePurchaseBudgetFromPurchaseOrder"), Authorize("SHOW_ORDER_QUOTATION_PURCHASE,ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE")]
        public ResponseData SavePurchaseBudgetFromPurchaseOrder([FromBody] int idDocument)

        {
            GetUserMail();
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.SavePurchaseBudgetFromPurchaseOrder(idDocument, userMail)
            };
            return result;

        }


        [HttpPost("assingMargin"), Authorize("UPDATE_RECEIPT_PURCHASE")]
        public ResponseData AssingMargin([FromBody] InputToCalculatePriceCostViewModel inputToCalculatePriceCostViewModel)

        {
            GetUserMail();
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDocument.AssingMargin(inputToCalculatePriceCostViewModel)
            };
            return result;

        }

        [HttpPost("getAvailbleQuantity")]
        public ResponseData GetAvailbleQuantity([FromBody] ItemQuantity itemQuantity)

        {
            GetUserMail();
            ResponseData result = new ResponseData
            {
                flag = 1
            };
            result.objectData = _serviceDocument.GetAvailbleQuantity(itemQuantity);
            return result;

        }

        [HttpPost("sendPriceRequestMailFromOrder"), Authorize("SEND_EMAIL_PRICEREQUEST")]
        public ResponseData SendPriceRequestMailFromOrder([FromBody] dynamic model)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            //get the user sended from generic factory service
            UserViewModel user = _userService.GetModel(x => x.Email == userMail);
            var obj = _serviceDocument.SendPriceRequestMailFromOrder((int)model.idDocument, model.informationType.ToString(), user, _smtpSettings, model.url.ToString());

            result.flag = 1;
            result.customStatusCode = CustomStatusCode.SendMailSuccessfull;
            result.objectData = obj;
            return result;
        }

        [HttpPost("saveRemplacementItem"), AllowAnonymous]
        public ResponseData SaveRemplacementItem([FromBody] dynamic model)
        {
            ResponseData result = new ResponseData();
            _serviceDocument.SaveRemplacementItem((int)model.idItem, (int)model.idDocumentLine, (string)model.code, (string)model.description);

            result.flag = 1;
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.objectData = new { EntityName = "ITEM" };
            return result;
        }

        [HttpPost("RecalculateDocumentAndDocumentLineAfterChangingCurrencyExchangeRate/{idDocument}"), AllowAnonymous]
        public ResponseData RecalculateDocumentAndDocumentLineAfterChangingCurrencyExchangeRate([FromBody] double exchangeRate, int idDocument)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDocument.RecalculateDocumentAndDocumentLineAfterChangingCurrencyExchangeRate(idDocument, exchangeRate),
                customStatusCode = CustomStatusCode.AddSuccessfull
            };
            return result;
        }


        [HttpPost("getDocumentLineOfBlNotAssociated")]
        public ResponseData GetDocumentLineOfBlNotAssociated([FromBody] int idTiersBS)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDocument.GetDocumentLineOfBlNotAssociated(idTiersBS),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }


        [HttpPost("updateBlsInRealTime")]
        public async Task UpdateBlsInRealTime([FromBody] List<int> idsBls)
        {
            _serviceDocument.UpdateBlsInRealTime(idsBls);
        }

        [HttpGet("getDocumentAvailibilityStockReserved/{id}"), Authorize("SHOW_DELIVERY_SALES,ADD_DELIVERY_SALES,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,COUNTER_SALES")]
        public ResponseData GetDocumentAvailibilityStock(int id)

        {
            GetUserMail();
            ResponseData result = new ResponseData
            {
                flag = 1
            };
            result.objectData = _serviceDocument.GetDocumentAvailibilityStockReserved(id);
            return result;

        }

        [HttpPost("getValidAssetsAndInvoice/{idClient}"), Authorize("LIST_INVOICE_ASSET_SALES")]
        public ResponseData getValidAssetsAndInvoice(int idClient, [FromBody] dynamic data)
        {
            var dataSourceResult = _serviceDocument.GetValidAssetsAndInvoice(idClient, data);

            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                }
            };
            return result;
        }

        /// <summary>
        /// download payslip
        /// </summary>
        /// <param name="id">id payslip to download</param>
        /// <returns></returns>
        [HttpGet("downloadSalesInvoice/{id}/{printType}/{isFromBL}"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> DownloadSalesInvoice(int id, int printType, int? isFromBL)
        {
            ResponseData responseData = new ResponseData();
            if (id != 0)
            {
                GetUserMailInvariant();
                ReportSettings reportSetting = _serviceDocument.GetInvoiceReportSettings(id, HttpContext, userMail, _printerSettings);
                reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
                reportSetting.PrintType = printType;
                reportSetting.IsFromBL = isFromBL ?? -1;
                //Create a new instance of HttpClient
                using (HttpClient client = new HttpClient())
                {
                    reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                    client.BaseAddress = _appSettings.ReportUrl;
                    client.DefaultRequestHeaders.Accept.Clear();

                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                    HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                    {
                        RequestUri = new Uri(reportApi, UriKind.Relative),
                        Method = HttpMethod.Post,
                        Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                    };

                    responseData.messsage = await client.SendAsync(httpRequestMessage);
                    responseData.messsage.EnsureSuccessStatusCode();
                    var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                    responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
                }
            }
            return responseData;
        }

        /// <summary>
        /// download payslip
        /// </summary>
        /// <param name="id">id payslip to download</param>
        /// <returns></returns>
        [HttpPost("downloadPurchaseDeliveryDoc"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> DownloadPurchaseDeliveryDoc([FromBody] DocumentDownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            if (data.Id != 0)
            {
                GetUserMailInvariant();
                ReportSettings reportSetting = _serviceDocument.GetInvoiceReportSettings(data.Id, HttpContext, userMail, _printerSettings);
                reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
                reportSetting.PrintType = data.PrintType;
                reportSetting.ReportName = "purchasedeliveryreport.trdp";
                reportSetting.IsFromBL = data.IsFromBl ?? -1;
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();

                //Create a new instance of HttpClient
                using (HttpClient client = new HttpClient())
                {
                    client.BaseAddress = _appSettings.ReportUrl;
                    client.DefaultRequestHeaders.Accept.Clear();

                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                    HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                    {
                        RequestUri = new Uri(reportApi, UriKind.Relative),
                        Method = HttpMethod.Post,
                        Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                    };

                    responseData.messsage = await client.SendAsync(httpRequestMessage);
                    responseData.messsage.EnsureSuccessStatusCode();
                    var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                    responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
                }
            }
            return responseData;
        }

        /// <summary>
        /// download payslip
        /// </summary>
        /// <param name="id">id payslip to download</param>
        /// <returns></returns>
        [HttpPost("downloadPurchaseDeliveryExpenseDoc"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> DownloadPurchaseDeliveryExpenseDoc([FromBody] DocumentDownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            if (data.Id != 0)
            {
                GetUserMailInvariant();
                ReportSettings reportSetting = _serviceDocument.GetInvoiceReportSettings(data.Id, HttpContext, userMail, _printerSettings);
                reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
                reportSetting.PrintType = data.PrintType;
                reportSetting.ReportName = "purchasedelivexpreport.trdp";
                reportSetting.IsFromBL = data.IsFromBl ?? -1;
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();


                //Create a new instance of HttpClient
                using (HttpClient client = new HttpClient())
                {
                    client.BaseAddress = _appSettings.ReportUrl;
                    client.DefaultRequestHeaders.Accept.Clear();

                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                    HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                    {
                        RequestUri = new Uri(reportApi, UriKind.Relative),
                        Method = HttpMethod.Post,
                        Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                    };

                    responseData.messsage = await client.SendAsync(httpRequestMessage);
                    responseData.messsage.EnsureSuccessStatusCode();
                    var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                    responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
                }
            }
            return responseData;
        }

        /// <summary>
        /// download payslip
        /// </summary>
        /// <param name="id">id payslip to download</param>
        /// <returns></returns>
        [HttpPost("downloadPurchaseDeliveryCostDoc"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> DownloadPurchaseDeliveryCostDoc([FromBody] DocumentDownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            if (data.Id != 0)
            {
                GetUserMailInvariant();
                ReportSettings reportSetting = _serviceDocument.GetInvoiceReportSettings(data.Id, HttpContext, userMail, _printerSettings);

                reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
                reportSetting.PrintType = data.PrintType;
                reportSetting.ReportName = "purchasedelivcostpreport.trdp";
                reportSetting.IsFromBL = data.IsFromBl ?? -1;
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();


                //Create a new instance of HttpClient
                using (HttpClient client = new HttpClient())
                {
                    client.BaseAddress = _appSettings.ReportUrl;
                    client.DefaultRequestHeaders.Accept.Clear();

                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                    HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                    {
                        RequestUri = new Uri(reportApi, UriKind.Relative),
                        Method = HttpMethod.Post,
                        Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                    };

                    responseData.messsage = await client.SendAsync(httpRequestMessage);
                    responseData.messsage.EnsureSuccessStatusCode();
                    var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                    responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
                }
            }
            return responseData;
        }


        /// <summary>
        /// download payslip
        /// </summary>
        /// <param name="id">id payslip to download</param>
        /// <returns></returns>
        [HttpGet("downloadPurchaseDoc/{id}/{printType}/{isFromBL}"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> DownloadPurchaseDoc(int id, int printType, int? isFromBL)
        {
            ResponseData responseData = new ResponseData();
            if (id != 0)
            {
                GetUserMailInvariant();
                var listReportSettings = new List<ReportSettings>();
                ReportSettings reportSetting = _serviceDocument.GetInvoiceReportSettings(id, HttpContext, userMail, _printerSettings);
                reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
                reportSetting.PrintType = printType;
                reportSetting.ReportName = "purchasedeliveryreport.trdp";
                reportSetting.IsFromBL = isFromBL ?? -1;
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                listReportSettings.Add(reportSetting);
                reportSetting = _serviceDocument.GetInvoiceReportSettings(id, HttpContext, userMail, _printerSettings);
                reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
                reportSetting.PrintType = printType;
                reportSetting.ReportName = "purchasedelivexpreport.trdp";
                reportSetting.IsFromBL = isFromBL ?? -1;
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                listReportSettings.Add(reportSetting);
                reportSetting = _serviceDocument.GetInvoiceReportSettings(id, HttpContext, userMail, _printerSettings);
                reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
                reportSetting.PrintType = printType;
                reportSetting.ReportName = "purchasedelivcostpreport.trdp";
                reportSetting.IsFromBL = isFromBL ?? -1;
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                listReportSettings.Add(reportSetting);

                //Create a new instance of HttpClient
                using (HttpClient client = new HttpClient())
                {
                    client.BaseAddress = _appSettings.ReportUrl;
                    client.DefaultRequestHeaders.Accept.Clear();

                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                    HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                    {
                        RequestUri = new Uri(reportDownloadPurchaseDocApi, UriKind.Relative),
                        Method = HttpMethod.Post,
                        Content = new StringContent(JsonConvert.SerializeObject(listReportSettings), Encoding.UTF8, jsonHeaderType)
                    };

                    responseData.messsage = await client.SendAsync(httpRequestMessage);
                    responseData.messsage.EnsureSuccessStatusCode();
                    var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                    responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
                }
            }
            return responseData;
        }


        /// <summary>
        /// download payslip
        /// </summary>
        /// <param name="id">id payslip to download</param>
        /// <returns></returns>
        [HttpGet("printSalesInvoice/{id}/{printType}/{printCopies}/{isFromBL}"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> PrintSalesInvoice(int id, int printType, int? printCopies, int? isFromBL)
        {
            ResponseData responseData = new ResponseData();
            if (id != 0)
            {
                GetUserMailInvariant();
                ReportSettings reportSetting = _serviceDocument.GetInvoiceReportSettings(id, HttpContext, userMail, _printerSettings);
                reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
                reportSetting.PrintType = printType;
                reportSetting.IsFromBL = isFromBL ?? -1;
                if (printCopies != null && printCopies != 0)
                {
                    reportSetting.NumberofCopies = (int)printCopies;
                }
                //Create a new instance of HttpClient
                using (HttpClient client = new HttpClient())
                {
                    reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                    client.BaseAddress = _appSettings.ReportUrl;
                    client.DefaultRequestHeaders.Accept.Clear();

                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                    HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                    {
                        RequestUri = new Uri(reportPrintApi, UriKind.Relative),
                        Method = HttpMethod.Post,
                        Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                    };

                    responseData.messsage = await client.SendAsync(httpRequestMessage);
                    try
                    {
                        responseData.messsage.EnsureSuccessStatusCode();
                    }
                    catch (Exception e)
                    {
                        _logger.LogError(e.Message + e.StackTrace + e.ToString());
                        throw new CustomException(CustomStatusCode.NO_PRINTER_INSTALLED);
                    }

                }
            }
            return responseData;
        }

        [HttpPost("ofConfirmation"), Authorize("INVALIDATE_INVOICE_SALES")]
        public ResponseData OfConfirmation([FromBody] int id)
        {
            _serviceDocument.OfConfirmation(id);
            return new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = new CreatedDataViewModel { EntityName = "DOCUMENT" },
                flag = 1,
            };


        }

        [HttpPost("reValidate"), Authorize("VALIDATE_INVOICE_SALES")]
        public ResponseData ReValidate([FromBody] int id)
        {
            _serviceDocument.ReValidate(id);
            return new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = new CreatedDataViewModel { EntityName = "DOCUMENT" },
                flag = 1,
            };
        }

        [HttpPost("getProvisionalBl"), Authorize("FUSION_DELIVERY_SALES")]
        public ResponseData GetProvisionalBl([FromBody] ProvisionalSDFilterViewModel provisionalSDFilter)
        {
            var dataSourceResult = _serviceDocument.GetProvisionalBl(provisionalSDFilter);
            ResponseData result = new ResponseData
            {
                flag = 2,
                listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                }
            };
            return result;
        }

        [HttpGet("getFailedSalesDeliveryCount"), Authorize("LIST_DELIVERY_SALES,DELIVER_DELIVERY_SALES")]
        public ResponseData getFailedSalesDeliveryCount()
        {
            if (!RoleHelper.HasPermission(RoleHelper.Ecommerce_Config))
            {
                return null;
            }
            //Pleae move this Methode to ecommerc Controller
            int dataSourceResult = 0;
            ResponseData result = new ResponseData
            {
                flag = 2,
                customStatusCode = CustomStatusCode.GetSuccessfull

            };
            result.listObject = new ListObject
            {
                listData = null,
                total = dataSourceResult
            };
            return result;
        }


        /// <summary>
        /// download payslip
        /// </summary>
        /// <param name="id">id payslip to download</param>
        /// <returns></returns>generateTermInvoice
        [HttpPost("multiPrintSalesInvoice"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> MultiPrintSalesInvoice([FromBody] DocumentDownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            if (data.ListIds.Count() != 0)
            {
                GetUserMailInvariant();
                var listRepSettings = new List<ReportSettings>();

                string reportConstant = data.IsFromBl == 1 ? DocumentConstant.SIMultiReportName : DocumentConstant.SIAMultiReportName;
                for (int i = 0; i < data.ListIds.Count(); i++)
                {
                    ReportSettings reportSetting = _serviceDocument.GetInvoiceReportSettings(data.ListIds[i], HttpContext, userMail, _printerSettings);
                    reportSetting.ReportName = reportConstant;
                    reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
                    reportSetting.PrintType = data.PrintType;
                    reportSetting.IsFromBL = data.IsFromBl ?? 0;
                    reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                    listRepSettings.Add(reportSetting);
                }
                //Create a new instance of HttpClient
                using (HttpClient client = new HttpClient())
                {

                    client.BaseAddress = _appSettings.ReportUrl;
                    client.DefaultRequestHeaders.Accept.Clear();

                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                    HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                    {
                        RequestUri = new Uri(reportMultiPrintApi, UriKind.Relative),
                        Method = HttpMethod.Post,
                        Content = new StringContent(JsonConvert.SerializeObject(listRepSettings), Encoding.UTF8, jsonHeaderType)
                    };

                    responseData.messsage = await client.SendAsync(httpRequestMessage);
                    try
                    {
                        responseData.messsage.EnsureSuccessStatusCode();
                        var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                        responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
                    }
                    catch (Exception e)
                    {
                        _logger.LogError(e.Message + e.StackTrace + e.ToString());
                        throw new CustomException(CustomStatusCode.NO_PRINTER_INSTALLED);
                    }

                }
            }
            return responseData;
        }

        /// <summary>
        /// download payslip
        /// </summary>
        /// <param name="id">id payslip to download</param>
        /// <returns></returns>generateTermInvoice
        [HttpPost("multiPrintSalesInvoiceJasper"), Authorize("PRINT_TERM_BILLING")]
        public async Task<ResponseData> MultiPrintSalesInvoiceJasper([FromBody] DocumentDownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            if (data.ListIds.Count() != 0)
            {
                GetUserMailInvariant();
                //string reportConstant = data.IsFromBl == 1 ? DocumentConstant.SIMultiReportName : DocumentConstant.SIAMultiReportName;
                _service.UpdateReportSettings(data);
                //data.ReportName = reportConstant.Replace(".trdp", "");
                responseData.objectData = await _serviceJasperReporting.ExecuteMultipleJasperReport(data, userMail);

                return responseData;
            }
            return responseData;
        }

        /// <summary>
        /// Get Daily Sales Information
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        [HttpPost("downloadDailySales"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> DownloadDailySales([FromBody] DocumentDownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            ReportSettings reportSetting = _serviceDocument.GetInvoiceReportSettings(HttpContext, userMail, _printerSettings, "dailysales", null, -1);
            reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
            reportSetting.PrintType = data.PrintType;
            reportSetting.IdWarehouse = data.Idwarehouse;


            //Create a new instance of HttpClient
            using (HttpClient client = new HttpClient())
            {
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                client.BaseAddress = _appSettings.ReportUrl;
                client.DefaultRequestHeaders.Accept.Clear();

                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                {
                    RequestUri = new Uri(dailySalesReportApi, UriKind.Relative),
                    Method = HttpMethod.Post,
                    Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                };

                responseData.messsage = await client.SendAsync(httpRequestMessage);
                responseData.messsage.EnsureSuccessStatusCode();
                var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
            }
            return responseData;
        }

        /// <summary>
        /// Get Daily Sales Information
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        [HttpPost("downloadJasperDailySales"), Authorize("PRINT_SALES_JOURNAL")]
        public async Task<ResponseData> DownloadJasperDailySales([FromBody] DocumentDownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            var parsedStartDate = DateTime.Parse(data.Reportparameters.startdate.Value);
            var parsedEndDate = DateTime.Parse(data.Reportparameters.enddate.Value);

            if (data.Reportparameters.startdate != null)
            {
                data.Reportparameters.startdate = parsedStartDate.Year + "," + parsedStartDate.Month + "," + parsedStartDate.Day;
            }
            else
            {
                data.Reportparameters.startdate = "-1";
            }

            if (data.Reportparameters.enddate != null)
            {
                data.Reportparameters.enddate = parsedEndDate.Year + "," + parsedEndDate.Month + "," + parsedEndDate.Day;
            }
            else
            {
                data.Reportparameters.enddate = "-1";
            }
            _serviceDocument.UpdateReportSettings(data);
            responseData.objectData = await _serviceJasperReporting.ExecuteJasperReport(data, userMail);

            return responseData;
        }

        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpPost("downloadDailySalesDelivery"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> DownloadDailySalesDelivery([FromBody] DocumentDownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            ReportSettings reportSetting = _serviceDocument.GetInvoiceReportSettings(HttpContext, userMail, _printerSettings, "dailysalesdelivery", null, -1);
            reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
            reportSetting.PrintType = data.PrintType;
            reportSetting.IdTiers = data.Idtiers;
            reportSetting.IdStatus = data.Idstatus;

            if (data.Startdate != null)
            {
                reportSetting.startdate = data.Startdate.Value.Year + "," + data.Startdate.Value.Month + "," + data.Startdate.Value.Day;
            }
            else
            {
                reportSetting.startdate = "-1";
            }

            if (data.Enddate != null)
            {
                reportSetting.enddate = data.Enddate.Value.Year + "," + data.Enddate.Value.Month + "," + data.Enddate.Value.Day;
            }
            else
            {
                reportSetting.enddate = "-1";
            }

            reportSetting.ReportParameters = data.Reportparameters;



            //Create a new instance of HttpClient
            using (HttpClient client = new HttpClient())
            {
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                client.BaseAddress = _appSettings.ReportUrl;
                client.DefaultRequestHeaders.Accept.Clear();

                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                {
                    RequestUri = new Uri(dailySalesReportApi, UriKind.Relative),
                    Method = HttpMethod.Post,
                    Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                };

                responseData.messsage = await client.SendAsync(httpRequestMessage);
                responseData.messsage.EnsureSuccessStatusCode();
                var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
            }
            return responseData;
        }

        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpPost("downloadJasperDailySalesDelivery"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> DownloadJasperDailySalesDelivery([FromBody] DocumentDownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            ReportSettings reportSetting = _serviceDocument.GetInvoiceReportSettings(HttpContext, userMail, _printerSettings, "dailysalesdelivery", null, -1);
            reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
            reportSetting.PrintType = data.PrintType;
            reportSetting.IdTiers = data.Idtiers;
            reportSetting.IdStatus = data.Idstatus;

            if (data.Startdate != null)
            {
                reportSetting.startdate = data.Startdate.Value.Year + "," + data.Startdate.Value.Month + "," + data.Startdate.Value.Day;
            }
            else
            {
                reportSetting.startdate = "-1";
            }

            if (data.Enddate != null)
            {
                reportSetting.enddate = data.Enddate.Value.Year + "," + data.Enddate.Value.Month + "," + data.Enddate.Value.Day;
            }
            else
            {
                reportSetting.enddate = "-1";
            }

            reportSetting.ReportParameters = data.Reportparameters;



            //Create a new instance of HttpClient
            using (HttpClient client = new HttpClient())
            {
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                client.BaseAddress = _appSettings.ReportUrl;
                client.DefaultRequestHeaders.Accept.Clear();

                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                {
                    RequestUri = new Uri(dailySalesReportApi, UriKind.Relative),
                    Method = HttpMethod.Post,
                    Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                };

                responseData.messsage = await client.SendAsync(httpRequestMessage);
                responseData.messsage.EnsureSuccessStatusCode();
                var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
            }
            return responseData;
        }

        [HttpPost("applyDiscountForAllDocumentLines/{discount}/{id}")]
        public ResponseData ApplyDiscountForAllDocumentLines(double discount, int id)
        {
            var document = _serviceDocument.GetModelAsNoTracked(x => x.Id == id);
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(document.DocumentTypeCode, AutorizationActionConstants.AuthorizationUpdate);

            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                return new ResponseData
                {
                    objectData = _serviceDocument.ApplyDiscountForAllDocumentLines(discount, id),
                    customStatusCode = CustomStatusCode.UpdateSuccessfull,
                    flag = 1,
                };

            }
        }
        [HttpPost("deleteAll/{id}"), Authorize("DELETE_LINE_SALES,DELETE_LINE_PURCHASE,DELETE_MULTIPLE_LINES_STOCK_CORRECTION,COUNTER_SALES")]
        public ResponseData DeleteAllLinesFromId([FromBody] List<int> idList, [FromHeader] int id)
        {
            return new ResponseData
            {
                objectData = _serviceDocument.DeleteAllLinesFromId(idList),
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = 1,
            };
        }

        [HttpPost("importLineToInvoiced")]
        public virtual ResponseData ImportLineToInvoiced([FromBody] ItemPriceViewModel itemPriceViewModel)
        {

            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(itemPriceViewModel.DocumentType, AutorizationActionConstants.AuthorizationAdd);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                DocumentViewModel document = _serviceDocument.ImportLineToInvoiced(itemPriceViewModel);
                ResponseData result = new ResponseData
                {
                    objectData = document,
                    customStatusCode = CustomStatusCode.GetSuccessfull,
                    flag = 1
                };
                return result;
            }
        }

        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpPost("downloadDocumentControlStatus"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> DownloadDocumentControlStatus([FromBody] DocumentDownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            ReportSettings reportSetting = _serviceDocument.GetInvoiceReportSettings(HttpContext, userMail, _printerSettings, "documentcontrolstatus", data.Idtype, data.Groupbytiers);
            reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
            reportSetting.PrintType = data.PrintType;
            reportSetting.IdTiers = data.Idtiers;
            reportSetting.IdStatus = data.Idstatus;
            reportSetting.IdType = data.Idtype;


            if (data.Startdate != null)
            {
                reportSetting.startdate = data.Startdate.Value.Year + "," + data.Startdate.Value.Month + "," + data.Startdate.Value.Day;
            }
            else
            {
                reportSetting.startdate = "-1";
            }

            if (data.Enddate != null)
            {
                reportSetting.enddate = data.Enddate.Value.Year + "," + data.Enddate.Value.Month + "," + data.Enddate.Value.Day;
            }
            else
            {
                reportSetting.enddate = "-1";
            }

            //Create a new instance of HttpClient
            using (HttpClient client = new HttpClient())
            {
                reportSetting.UploadFilePath = Directory.GetCurrentDirectory();
                client.BaseAddress = _appSettings.ReportUrl;
                client.DefaultRequestHeaders.Accept.Clear();

                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(jsonHeaderType));
                HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                {
                    RequestUri = new Uri(dailySalesReportApi, UriKind.Relative),
                    Method = HttpMethod.Post,
                    Content = new StringContent(JsonConvert.SerializeObject(reportSetting), Encoding.UTF8, jsonHeaderType)
                };

                responseData.messsage = await client.SendAsync(httpRequestMessage);
                responseData.messsage.EnsureSuccessStatusCode();
                var json = responseData.messsage.Content.ReadAsStringAsync().Result;
                responseData.objectData = JsonConvert.DeserializeObject<FileInfoViewModel>(json);
            }
            return responseData;
        }

        /// <summary>
        /// Get Daily Sales delivery Information Line
        /// </summary>
        /// <param name="idtiers"></param>
        /// <param name="idstatus"></param>
        /// <param name="startdate"></param>
        /// <param name="enddate"></param>
        /// <returns></returns>
        [HttpPost("downloadJasperDocumentControlStatus"), Authorize("PRINT_DOCUMENT_STATUS_CONTROL")]
        public async Task<ResponseData> DownloadJasperDocumentControlStatus([FromBody] DocumentDownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            ReportSettings reportSetting = _serviceDocument.GetInvoiceReportSettings(HttpContext, userMail, _printerSettings, "documentcontrolstatus", data.Idtype, data.Groupbytiers);
            reportSetting.ReportConnectionString = _serviceDocument.GetConnectionString();
            reportSetting.PrintType = data.PrintType;
            reportSetting.IdTiers = data.Idtiers;
            reportSetting.IdStatus = data.Idstatus;
            reportSetting.IdType = data.Idtype;


            if (data.Startdate != null)
            {
                reportSetting.startdate = data.Startdate.Value.Year + "," + data.Startdate.Value.Month + "," + data.Startdate.Value.Day;
            }
            else
            {
                reportSetting.startdate = "-1";
            }

            if (data.Enddate != null)
            {
                reportSetting.enddate = data.Enddate.Value.Year + "," + data.Enddate.Value.Month + "," + data.Enddate.Value.Day;
            }
            else
            {
                reportSetting.enddate = "-1";
            }
            _service.UpdateReportSettings(data);
            responseData.objectData = await _serviceJasperReporting.ExecuteJasperReport(data, userMail);
            return responseData;
        }

        [HttpPost("getDataSourcePredicateDocumentControl"), Authorize("LIST_DOCUMENT_STATUS_CONTROL")]
        public ResponseData GetDataSourcePredicateDocumentControl([FromBody] PredicateFormatViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            var typeFilter = model.Filter.Where(x => x.Prop == "DocumentTypeCode").ToList();
            var docTypeFilters = _serviceDocument.filterByDocumentType(typeFilter.FirstOrDefault());
            //bool hasRole = true;
            //var filter = docTypeFilters.Where(x => x.Prop == "DocumentTypeCode").ToList();
            //filter.ForEach(item =>
            //{
            //    string documentTypeCode = item.Value.ToString();
            //    if (!RoleHelper.hasDocumentPermission(new List<string> { AutorizationActionConstants.AuthorizationList }, documentTypeCode))
            //    {
            //        hasRole = false;
            //    }
            //});

            //if (!hasRole)
            //{
            //    return new ResponseData
            //    {
            //        customStatusCode = CustomStatusCode.Unauthorized
            //    };
            //}

            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceDocument.FindDocumentControlList(model);

            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }
        [HttpPost("cancelDocument"), Authorize("CANCEL_ORDER_SALES")]
        public virtual ResponseData cancelDocument([FromBody] int idDocument)
        {
            bool hasRole = RoleHelper.HasPermission(RoleHelper.Cancel_Order_Sales);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                _serviceDocument.CancelDocument(idDocument);
                ResponseData result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.GetSuccessfull,
                    flag = 1
                };
                return result;
            }
        }

        [HttpPost("getDocumentLineOfBsNotAssociated")]
        public ResponseData GetDocumentLineOfBsNotAssociated([FromBody] PredicateWithDateFilterInformationViewModel dateFilter)
        {

            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDocument.GetDocumentLinesToInvoicePanier(dateFilter),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        [HttpPost("setDocumentLineSalePolicy"), Authorize("UPDATE_RECEIPT_PURCHASE")]
        public ResponseData SetDocumentLineSalePolicy([FromBody] dynamic data)
        {
            int IdDocument = (int)data.IdDocument;
            int IdLine = data.IdLine != null ? (int)data.IdLine : 0;
            int IdPloicy = (int)data.IdPolicy;
            _serviceDocument.SetDocumentLineSalePolicy(IdDocument, IdPloicy, IdLine);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        [HttpPost("getDocumentLineCost/{idLine}")]
        public ResponseData GetDocumentLineCost(int idLine)
        {

            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetDocumentLineCost(idLine),
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        [HttpPost("setDocumentDelivered"), Authorize("DELIVER_DELIVERY_SALES")]
        public ResponseData SetDocumentDelivered([FromBody] dynamic data)
        {
            GetUserMail();
            int idDoc = int.Parse(data.idDocument.ToString());
            DocumentViewModel documentToCheck = _serviceDocument.GetModelAsNoTracked(x => x.Id == idDoc);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            result.objectData = _serviceDocument.SetDocumentDelivered(idDoc, bool.Parse(data.isDelivered.ToString()), userMail);
            return result;

        }

        [HttpPost("getBalancedList")]
        public ResponseData GetBalancedList([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            int idTier = objectToSave.model.idTier;
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetBalancedListWithPredicate(idTier, predicate),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpPost("cancelBalancedDocLine"), Authorize("SHOW_UPDATE_BALANCE_PURCHASE")]
        public ResponseData CancelBalancedDocLine([FromBody] int idDocLine)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.CancelBalancedDocLine(idDocLine),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpPost("saveBalancedDocLine"), Authorize("SHOW_UPDATE_BALANCE_PURCHASE")]
        public ResponseData SaveBalancedDocLine([FromBody] BalanceDocumentLine docLine)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.SaveBalancedDocLine(docLine),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpPost("isAnyLineWithoutPrice"), Authorize("VALIDATE_ORDER_QUOTATION_PURCHASE,VALIDATE_FINAL_ORDER_PURCHASE,VALIDATE_INVOICE_PURCHASE,VALIDATE_ASSET_PURCHASE,VALIDATE_QUOTATION_SALES,VALIDATE_RECEIPT_PURCHASE," +
            "VALIDATE_FINANCIAL_ASSET_SALES,VALIDATE_INVOICE_ASSET_SALES,VALIDATE_ORDER_SALES,VALIDATE_ASSET_SALES,VALIDATE_INVOICE_SALES,VALIDATE_DELIVERY_SALES,VALIDATE_ADMISSION_VOUCHERS,VALIDATE_EXIT_VOUCHERS")]
        public ResponseData IsAnyLineWithoutPrice([FromBody] int idDoc)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.IsAnyLineWithoutPrice(idDoc)
            };
            return result;
        }

        [HttpPost("getDocumentsAssociated"), Authorize("LIST_INVOICE_PURCHASE,LIST_ASSET_PURCHASE,LIST_ORDER_SALES,LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_ORDER_QUOTATION_PURCHASE," +
            "LIST_RECEIPT_PURCHASE,LIST_FINAL_ORDER_PURCHASE")]
        public ResponseData GetDocumentsAssociated([FromBody] PredicateFormatViewModel predicate)
        {


            ResponseData result = new ResponseData
            {
                objectData = _serviceDocumentLine.GetDocumentsAssociated(predicate),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpGet("getDocumentsAssociatedForPriceRequest/{documentId}")]
        public ResponseData GetDocumentsAssociatedForPriceRequest(int documentId)
        {


            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetDocumentsAssociatedForPriceRequest(documentId),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpPost("massValidate")]
        public ResponseData MassValidate([FromBody] List<DocumentViewModel> DocumentList)
        {


            if (DocumentList == null)
            {
                throw new ArgumentNullException(nameof(DocumentList));
            }
            if (DocumentList.Count == 0)
            {
                ResponseData result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.NoDocumentSelectedForMassValidation,
                    flag = 1
                };
                return result;
            }
            string documentTypeCode = GetDocumentTypeCode(DocumentList[0].Id);
            bool hasRole = SpecificAuthorizationCheck.DocumentAuthorization(documentTypeCode, AutorizationActionConstants.AuthorizationValidate);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            else
            {
                GetUserMail();
                ResponseData result = new ResponseData
                {
                    objectData = _serviceDocument.MassValidateDocuments(DocumentList, userMail),
                    customStatusCode = CustomStatusCode.SuccessValidation,
                    flag = 1
                };
                return result;
            }
        }

        [HttpPost("getDiscountValue"), Authorize("ADD_QUOTATION_SALES,UPDATE_QUOTATION_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES," +
            "UPDATE_ASSET_SALES,ADD_ASSET_SALES,UPDATE_VALID_ASSET_SALES,SHOW_INVOICE_SALES,UPDATE_INVOICE_SALES,ADD_INVOICE_SALES")]
        public DocumentLineViewModel getDiscountValue([FromBody] ItemPriceViewModel itemPriceViewModel)
        {
            if (itemPriceViewModel == null)
            {
                throw new ArgumentNullException(nameof(itemPriceViewModel));
            }
            DocumentLineViewModel result = _serviceDocument.getDiscountValue(itemPriceViewModel);
            return result;
        }

        [HttpGet("getNumberDaysOutStockCurrentYear/{idItem}"), Authorize("DETAILS_ITEM,UPDATE_ITEM")]
        public ResponseData GetNumberDaysOutStockCurrentYear(int idItem)
        {
            return new ResponseData
            {
                objectData = _serviceDocument.CalculateNumberDaysOutStockCurrentYear(idItem),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
        }
        [HttpPost("getDataWithSpecificFilter"), Authorize("LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES,LIST_FINANCIAL_ASSET_SALES," +
            "LIST_ORDER_QUOTATION_PURCHASE,LIST_FINAL_ORDER_PURCHASE,LIST_RECEIPT_PURCHASE,LIST_INVOICE_PURCHASE,LIST_ASSET_PURCHASE,LIST_ADMISSION_VOUCHERS,LIST_EXIT_VOUCHERS,LIST_PURCHASE_REQUEST")]
        public override ResponseData GetDataWithSpecificFilter([FromBody] List<PredicateFormatViewModel> model)
        {

            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _serviceDocument.GetListDataWithSpecificFilter(model);

                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total,
                    sum = dataSourceResult.sum
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;

        }

        [HttpPost("getPictures"), Authorize("LIST_QUOTATION_SALES,LIST_ORDER_SALES,LIST_DELIVERY_SALES,LIST_INVOICE_SALES,LIST_ASSET_SALES,LIST_INVOICE_ASSET_SALES,LIST_FINANCIAL_ASSET_SALES,LIST_ORDER_QUOTATION_PURCHASE," +
            "LIST_FINAL_ORDER_PURCHASE,LIST_RECEIPT_PURCHASE,LIST_INVOICE_PURCHASE,LIST_ASSET_PURCHASE,LIST_ADMISSION_VOUCHERS,LIST_EXIT_VOUCHERS,DELIVER_DELIVERY_SALES")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {

            return base.getPictures(paths);
        }

        [HttpGet("getById/{id}")]
        public override ResponseData GetById(int id)
        {
            ResponseData result = new ResponseData();
            DocumentViewModel documentViewModel = _serviceDocument.FindDocumentWithDocumentLine(id, userMail);
            List<string> actions = new List<string> { AutorizationActionConstants.AuthorizationAdd, AutorizationActionConstants.AuthorizationUpdate, AutorizationActionConstants.AuthorizationShow };
            bool hasRole = RoleHelper.hasDocumentPermission(actions, documentViewModel.DocumentTypeCode, documentViewModel.IsRestaurn != null ? (bool)documentViewModel.IsRestaurn : false);
            if (!hasRole)
            {
                return new ResponseData
                {
                    customStatusCode = CustomStatusCode.Unauthorized
                };
            }
            return base.GetById(id);
        }
        [HttpPost("ValidateOrderBtoB"), Authorize("VALIDATE_ORDER_QUOTATION_PURCHASE,VALIDATE_FINANCIAL_ASSET_SALES,VALIDATE_INVOICE_ASSET_SALES" +
            "VALIDATE_FINAL_ORDER_PURCHASE,VALIDATE_INVOICE_PURCHASE,VALIDATE_ASSET_PURCHASE,VALIDATE_QUOTATION_SALES,VALIDATE_RECEIPT_PURCHASE,VALIDATE_ORDER_SALES,VALIDATE_ASSET_SALES,VALIDATE_INVOICE_SALES,VALIDATE_DELIVERY_SALES,VALIDATE_ADMISSION_VOUCHERS,VALIDATE_EXIT_VOUCHERS")]
        public async Task<ResponseData> ValidateOrderBtoB([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            GetUserMail();
            ResponseData result = new ResponseData
            {
                objectData = await _serviceDocument.ValidateOrderBtoB(int.Parse(objectToSave.model, CultureInfo.InvariantCulture), userMail),
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = 1
            };
            return result;
        }
        [HttpPost("isAnyRelationSupplierWithItem"), Authorize("ADMISSION_VOUCHERS,UPDATE_STOCK_CORRECTION_DISCOUNT,VALIDATE_ORDER_QUOTATION_PURCHASE,VALIDATE_FINAL_ORDER_PURCHASE,VALIDATE_INVOICE_PURCHASE,VALIDATE_ASSET_PURCHASE,VALIDATE_RECEIPT_PURCHASE,ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE")]
        public ResponseData IsAnyRelationSupplierWithItem([FromBody] dynamic itemPrice)
        {
            int IdItem = (int)itemPrice.IdItem;
            int IdTier = (int)itemPrice.IdTier;
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.IsAnyRelationSupplierWithItem(IdTier, IdItem)
            };
            return result;
        }
        [HttpPost("CanceledOrderBtobFromStark"), Authorize("CANCEL_ORDER_SALES")]
        public async Task<ResponseData> CanceledOrderBtobFromStark([FromBody] int idDocument)
        {
            ResponseData result = new ResponseData
            {
                objectData = await _serviceDocument.CanceledOrderBtobFromStark(idDocument),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST,SHOW_TIMESHEET,UPDATE_TIMESHEET,GENERATE_BILLING_SESSION_INVOICES")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("SynchronizeAllBToBDocuments"), Authorize("SYNCHRONIZATION_ORDERS_BTOB")]
        public ResponseData SynchronizeAllBToBDocuments()
        {
            GetUserMail();
            _serviceDocument.SynchronizeAllBToBDocuments(userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = 1
            };
            return result;
        }
        [HttpPost("getDocumentByCondition"), Authorize("ADD_BILLING_SESSION,UPDATE_BILLING_SESSION,SHOW_BILLING_SESSION,GENERATE_BILLING_SESSION_INVOICES")]
        public DocumentViewModel GetDocumentByCondition([FromBody] dynamic condition)
        {
            int idTimeSheet = (int)condition.IdTimeSheet;
            int idProject = (int)condition.IdProject;
            string documentTypeCode = (string)condition.DocumentTypeCode;
            return _serviceDocument.GetModel(y => y.IdTimeSheet == idTimeSheet && y.IdProject == idProject && y.DocumentTypeCode.Equals(documentTypeCode));
        }

        [HttpPost("getNewDocumentForBillingSession"), Authorize("GENERATE_BILLING_SESSION_INVOICES")]
        public DocumentViewModel GetNewDocumentForBillingSession([FromBody] DocumentViewModel document)
        {
            GetUserMail();
            return _serviceDocument.GetNewDocumentForBillingSession(document, userMail);
        }

        [HttpPost("getDocumentsByBillingEmployees"), Authorize("ADD_BILLING_SESSION,UPDATE_BILLING_SESSION,SHOW_BILLING_SESSION")]
        public List<DocumentViewModel> GetDocumentsByBillingEmployees([FromBody] List<BillingEmployeeViewModel> billingEmployeeViewModels)
        {
            return _serviceDocument.GetDocumentsByBillingEmployees(billingEmployeeViewModels);
        }

        [HttpPost("generateDeliveryForms")]
        public ResponseData GenerateDeliveryForms([FromBody] ListOrdersViewModel listOrdersViewModel)

        {
            GetUserMail();
            var dataSourceResult = _serviceDocument.GenerateDeliveryForms(listOrdersViewModel);
            ResponseData result = new ResponseData
            {
                flag = 2,
                customStatusCode = CustomStatusCode.GetSuccessfull

            };
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            return result;
        }


        [HttpPost("createDeliveryForms")]
        public ResponseData CreateDeliveryForms([FromBody] ListOrdersViewModel listOrdersViewModel)

        {
            GetUserMail();
            var dataSourceResult = _serviceDocument.CreateDeliveryForms(listOrdersViewModel);
            ResponseData result = new ResponseData
            {
                flag = 2,
                customStatusCode = CustomStatusCode.GetSuccessfull

            };
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            return result;
        }
        [HttpPost("updateDocumentAfterChangeTtcPrice")]
        public virtual ResponseData UpdateDocumentAfterChangeTtcPrice([FromBody] dynamic data)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            int IdDocument = (int)data.IdDocument;
            double DocumentAmount = (double)data.DocumentTtcPrice;
            result.objectData = _serviceDocument.UpdateDocumentAfterChangeTtcPrice(IdDocument, DocumentAmount, userMail);
            return result;
        }



        [HttpPost("generateDepositInvoiceFromOrder"), Authorize("LIST_ORDER_SALES")]
        public DocumentViewModel GenerateDepositInvoiceFromOrder([FromBody] dynamic model)

        {
            GetUserMail();
            int idDoc = (int)model.IdDocument;
            int idItem = (int)model.IdItem;
            double amount = (double)model.Amount;
            return  _serviceDocument.GenerateDepositSalesInvoice(idDoc, amount, idItem, userMail);
        }


        [HttpPost("isValidDepositInvoiceStatus"), Authorize("LIST_ORDER_SALES")]
        public bool IsValidDepositInvoiceStatus([FromBody] dynamic objectToCheck)
        {
            if (objectToCheck == null)
            {
                throw new ArgumentNullException(nameof(objectToCheck));
            }
            int idDepositInvoice = (int)objectToCheck.IdDepositInvoice;
            int idOrder = (int)objectToCheck.IdOrder;
            bool result = _serviceDocument.IsValidDepositInvoiceStatus(idDepositInvoice, idOrder);
            return result;
        }

        [HttpPost("generateInvoiceFromOrder"), Authorize("LIST_ORDER_SALES")]
        public DocumentViewModel GenerateInvoiceFromOrder([FromBody] dynamic objectToCheck)
        {
            GetUserMail();
            if (objectToCheck == null)
            {
                throw new ArgumentNullException(nameof(objectToCheck));
            }
            int idDocument = (int)objectToCheck.IdDocument;
            return _serviceDocument.GenerateInvoiceFromOrder(idDocument, userMail);
        }

        [HttpPost("checkOrderToCancel"), Authorize("LIST_ORDER_SALES")]
        public CancelOrderViewModel CheckOrderToCancel([FromBody] dynamic objectToCheck)
        {
            GetUserMail();
            if (objectToCheck == null)
            {
                throw new ArgumentNullException(nameof(objectToCheck));
            }
            int idDocument = (int)objectToCheck.IdDocument;
            return _serviceDocument.CheckOrderToCancel(idDocument, userMail);
        }


        [HttpPost("checkInvoiceLinesToDelete"), Authorize("DELETE_INVOICE_SALES")]
        public DeleteInvoiceFromPosViewModel checkInvoiceLinesToDelete([FromBody] dynamic objectToCheck)
        {
            GetUserMail();
            if (objectToCheck == null)
            {
                throw new ArgumentNullException(nameof(objectToCheck));
            }
            int idInvoice = (int)objectToCheck.IdInvoice;
            List<int> Lines = objectToCheck.Lines.ToObject<List<int>>();
            return _serviceDocument.CheckInvoiceLinesToDelete(idInvoice, Lines, userMail);
        }

        #region Garage
        [HttpPost("getItemPriceForGarage")]
        public ResponseData GetItemPriceForGarage([FromBody] Dictionary<int, IList<dynamic>> dataParam)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetItemPriceForGarage(dataParam),
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("getOneItemPriceForGarage")]
        public ResponseData GetOneItemPriceForGarage([FromBody] dynamic dataParam)
        {
            int idItem = (int)dataParam.idItem;
            int? idWharehouse = (int?)dataParam.idWharehouse;
            double quantity = (double)dataParam.quantity;
            double? discount = (double?)dataParam.discount;
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetOneItemPriceForGarage(idWharehouse, idItem, quantity, discount),
                flag = 1,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("getItemPriceAndRemaningQuantityForGarage")]
        public ResponseData GetItemPriceAndRemaningQuantityForGarage([FromBody] dynamic dataParam)
        {
            Dictionary<int, double> itemIdAndQuanity = JsonConvert.DeserializeObject<Dictionary<int, double>>(dataParam.itemIdAndQuanity.ToString());
            int? idWarehouse = (int?)dataParam.idWarehouse;
            var dataSourceResult = _serviceDocument.GetItemPriceAndRemaningQuantityForGarage(itemIdAndQuanity, idWarehouse);
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

        [HttpPost("generateDeliveryForGarageInterventionOrder")]
        public ResponseData GenerateDeliveryForGarageInterventionOrder([FromBody] dynamic dataToSend)
        {
            IList<ReducedItemForGarage> reducedItemForGarages = JsonConvert.DeserializeObject<IList<ReducedItemForGarage>>(dataToSend.ReducedItems.ToString());
            int idTiers = (int)dataToSend.IdTiers;
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GenerateDeliveryForGarageInterventionOrder(idTiers, reducedItemForGarages),
                flag = 1,
                customStatusCode = CustomStatusCode.AddSuccessfull
            };
            return result;
        }

        [HttpPost("generateQuotationForGarageRepairOrder")]
        public ResponseData GenerateQuotationForGarageRepairOrder([FromBody] dynamic dataToSend)
        {
            IList<ReducedItemForGarage> reducedItemForGarages = JsonConvert.DeserializeObject<IList<ReducedItemForGarage>>(dataToSend.ReducedItems.ToString());
            int idTiers = (int)dataToSend.IdTiers;
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GenerateQuotationForGarageRepairOrder(idTiers, reducedItemForGarages),
                flag = 1,
                customStatusCode = CustomStatusCode.AddSuccessfull
            };
            return result;
        }


        [HttpPost("updateQuotationForGarageRepairOrder")]
        public ResponseData UpdateQuotationForGarageRepairOrder([FromBody] dynamic dataToSend)
        {
            IList<ReducedItemForGarage> reducedItemForGarages = JsonConvert.DeserializeObject<IList<ReducedItemForGarage>>(dataToSend.ReducedItems.ToString());
            int idQuotationDocument = (int)dataToSend.idQuotationDocument;
            bool validateDocument = (bool)dataToSend.validateDocument;
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.UpdateQuotationForGarageRepairOrder(idQuotationDocument, validateDocument, reducedItemForGarages),
                flag = 1,
                customStatusCode = CustomStatusCode.AddSuccessfull
            };
            return result;
        }


        [HttpPost("updateDeliveryAndGenerateEmptyInvoiceForGarageInterventionOrder")]
        public ResponseData UpdateDeliveryAndGenerateEmptyInvoiceForGarageInterventionOrder([FromBody] dynamic dataToSend)
        {
            IList<ReducedItemForGarage> reducedItemForGarages = JsonConvert.DeserializeObject<IList<ReducedItemForGarage>>(dataToSend.ReducedItems.ToString());
            int idDeliveryDocument = (int)dataToSend.IdDeliveryDocument;
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.UpdateDeliveryAndGenerateEmptyInvoiceForGarageInterventionOrder(idDeliveryDocument, reducedItemForGarages),
                flag = 1,
                customStatusCode = CustomStatusCode.UpdateSuccessfull
            };
            return result;
        }

        [HttpPost("importDeliveryIntoInvoiceForGarageInterventionOrder")]
        public ResponseData ImportDeliveryIntoInvoiceForGarageInterventionOrder([FromBody] ImportDocumentsViewModel importDocumentsViewModel)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.ImportDocuments(importDocumentsViewModel, null),
                flag = 1,
                customStatusCode = CustomStatusCode.UpdateSuccessfull
            };
            return result;
        }


        [HttpPost("getTiersAndItemAndDocumentForGarage")]
        public ResponseData GetInterventionDataForGarage([FromBody] dynamic model)
        {
            List<int> idItems = null;
            if (model.idItems != null)
            {
                idItems = JsonConvert.DeserializeObject<List<int>>(model.idItems.ToString());
            }
            int? idWarehouse = (int?)model.idWarehouse;
            int idTiers = (int)model.idTiers;
            int? idDocument = (int?)model.idDocument;
            var dataSourceResult = _serviceDocument.GetTiersAndItemAndDocumentForGarage(idTiers, idItems, idWarehouse, idDocument);
            ResponseData result = new ResponseData
            {
                objectData = dataSourceResult,
                flag = 2,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;

        }
        [HttpGet("getByIdForGarage")]
        public ResponseData GetByIdForGarage([FromBody] dynamic model)
        {
            int id = JsonConvert.DeserializeObject<int>(model.id.ToString());
            return base.GetById(id);
        }

        /// <summary>
        /// api to  check reserved lines
        /// </summary>
        /// <param name="idDocument"></param>
        /// <returns></returns>
        [HttpPost("checkReservedLines"), AllowAnonymous]
        public ResponseData CheckReservedLines([FromBody] int idDocument)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.CheckReservedLines(idDocument),
                flag = 1
            };
            return result;
        }
        /// <summary>
        /// api to generate invoice from delivery
        /// </summary>
        /// <param name="idsDocument"></param>
        /// <returns></returns>
        [HttpPost("generateInvoice")]
        public ResponseData GenerateBill([FromBody] int[] idsDocument)
        {
            GetUserMail();
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceDocument.GenerateInvoice(idsDocument, userMail)
            };
            return result;
        }

        #endregion

        #region Pos
        [HttpPost("generatePosInvoiceFromBl/{idDocument}/{idTicket}"), Authorize("GENERATE_INVOICE")]
        public ResponseData GeneratePosInvoiceFromBl(int idDocument, int idTicket, [FromBody] ObjectToSaveViewModel objectToSave)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            Document invoiceToGenerate = JsonConvert.DeserializeObject<Document>(objectToSave.model.invoiceToGenerate.ToString());
            bool isFromTickets = objectToSave.model.isFromTickets;
            List<int> idsDelivery = new List<int>();
            List<int> idsTickets = new List<int>(); 
            if (isFromTickets)
            {
                idsDelivery = JsonConvert.DeserializeObject<List<int>>(objectToSave.model.idsDelivery.ToString());
                idsTickets = JsonConvert.DeserializeObject<List<int>>(objectToSave.model.idsTickets.ToString());
            }
            result.objectData = _serviceDocument.GeneratePosInvoiceFromBl(idDocument, invoiceToGenerate, idTicket,isFromTickets, idsDelivery, idsTickets, userMail);
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.flag = 1;
            return result;

        }

        [HttpPost("deleteDocuments"), Authorize("COUNTER_SALES")]
        public ResponseData DeleteDocuments([FromBody] List<int> ids)
        {

            return new ResponseData
            {
                objectData = _serviceDocument.DeleteDocuments(ids, userMail),
                customStatusCode = CustomStatusCode.DeleteSuccessfull,
                flag = 2
            };

        }
        /// <summary>
        /// print note on turnover
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost("downloadJasperNoteOnTurnoverReport"), Authorize("PRINT_NOTE_ON_TURNOVER")]
        public async Task<ResponseData> DownloadJasperNoteOnTurnoverReport([FromBody] DocumentDownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            var parsedStartDate = DateTime.Parse(data.Reportparameters.startdate.Value);
            var parsedEndDate = DateTime.Parse(data.Reportparameters.enddate.Value);

            if (data.Reportparameters.startdate != null)
            {
                data.Reportparameters.startdate = parsedStartDate.Year + "," + parsedStartDate.Month + "," + parsedStartDate.Day;
            }
            else
            {
                data.Reportparameters.startdate = "-1";
            }

            if (data.Reportparameters.enddate != null)
            {
                data.Reportparameters.enddate = parsedEndDate.Year + "," + parsedEndDate.Month + "," + parsedEndDate.Day;
            }
            else
            {
                data.Reportparameters.enddate = "-1";
            }
            if (data.Reportparameters.idItem==null || (data.Reportparameters.idItem is string && data.Reportparameters.idItem==""))
            {
                data.Reportparameters.idItem = 0;
            } else
            if (data.Reportparameters.idItem == null || data.Reportparameters.idItem == "")
            {
                data.Reportparameters.idItem = 0;
            }

            _serviceDocument.UpdateReportSettings(data);
            responseData.objectData = await _serviceJasperReporting.ExecuteJasperReport(data, userMail);

            return responseData;
        }
        /// <summary>
        /// get list of note on turnover
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost("getNoteOnTurnoverLineList"), Authorize("LIST_NOTE_ON_TURNOVER")]
        public ResponseData GetNoteOnTurnoverLineList([FromBody] ObjectToSaveViewModel data)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceDocument.GetNoteOnTurnoverDataSource(data.model.startDate.ToString(), data.model.endDate.ToString(), (int)data.model.idItem);
            result.listObject = new ListObject
            {
                listData = dataSourceResult,
            };
            result.customStatusCode = CustomStatusCode.GetSuccessfull;
            result.flag = 2;
            return result;
        }
        [HttpPost("ExistingBLToBToBOrder")]
        public ResponseData ExistingBLToBToBOrder([FromBody] int idDocument)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.ExistingBLToBToBOrder(idDocument)
            };
            return result;
        }
        #endregion

    }
}
