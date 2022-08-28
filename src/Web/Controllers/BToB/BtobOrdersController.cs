using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence.Entities;
using Services.Reporting.Interfaces;
using Services.Specific.BToB.interfaces;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.B2B;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;
using ViewModels.DTO.Reporting.Generic;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Sales.Document;
using Web.Controllers.GenericController;

namespace Web.Controllers.BToB
{
    [Route("api/B2BOrder")]
    [AllowAnonymous]
    public class BtobOrdersController : BaseController
    {
        private readonly IServiceDocument _serviceDocument;
        private const string jsonHeaderType = "application/json";
        private const string reportApi = "api/customReports/downloadSalesInvoice";
        private const string connectionString = "connectionString";
        private readonly AppSettings _appSettings;
        private readonly PrinterSettings _printerSettings;
        private IServiceJasperReporting _serviceJasperReporting;
        private readonly IServiceUser _serviceUser;
        private readonly IServiceBToBShared _serviceBToBShared;
        private readonly IServiceItem _serviceItem;
        public BtobOrdersController(IServiceProvider serviceProvider, IServiceDocument serviceDocument, IOptions<AppSettings> appSettings, IOptions<PrinterSettings> printerSettings, IServiceUser serviceUser,
            ILogger<BtobOrdersController> logger, IServiceBToBShared serviceBToBShared , IServiceItem serviceItem) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceDocument = serviceDocument;
            if (appSettings != null)
            {
                _appSettings = appSettings.Value;
            }
            if (printerSettings != null)
            {
                _printerSettings = printerSettings.Value;
            }
            _serviceUser = serviceUser;
            _serviceBToBShared = serviceBToBShared;
            _serviceItem = serviceItem;
        }
        [HttpPost("getDocuments")]
        public virtual ResponseData GetB2BOrders([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceDocument.FindDocumentListForB2BDocument(model);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetSuccessfull;

            return result;
        }

        [HttpGet("getDocumentWithLines/{id}")]
        public virtual ResponseData GetDocumentWithLines(int id)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetDocumentWithLines(id),

                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };

            return result;
        }
        [HttpGet("GetDocument/{id}")]
        public virtual ResponseData GetDocument(int id)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetDocumentForB2b(id),

                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };

            return result;
        }
        [HttpPost("getItemPrices")]
        public ResponseData GetItemPrice([FromBody] BtoBDocumentLineViewModel btoBDocumentLineViewModel)
        {
            var user = _serviceUser.GetModelAsNoTracked(y => y.Email == btoBDocumentLineViewModel.UserMail);
            btoBDocumentLineViewModel.idUser = user.IdTiers;
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetItemPriceForB2BDocument(btoBDocumentLineViewModel),
                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };

            return result;
        }

        [HttpPost("getDocumentTotalPrice")]
        public ResponseData GetDocumentTotalPrice([FromBody] ReduisDocumentViewModel reduisDocumentViewModel)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetDocumentTotalPriceForB2BDocument(reduisDocumentViewModel),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }



        [HttpPost("sendDocument")]
        public ResponseData SendDocument([FromBody] int idDocument)
        {
            _serviceDocument.SendDocument(idDocument);
            ResponseData result = new ResponseData
            {

                customStatusCode = CustomStatusCode.AddSuccessfull,
                flag = 1
            };
            return result;
        }
        [HttpGet("deleteB2BDocument/{id}")]
        public ResponseData DeleteDocument(int id)
        {
            _serviceDocument.DeleteModel(id, "Document", null);
            ResponseData result = new ResponseData
            {

                customStatusCode = CustomStatusCode.AddSuccessfull,
                flag = 1
            };
            return result;
        }


        [HttpGet("getUserCurrency/{id}")]
        public ResponseData GetUserCurrency(int id)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.getUserCurrency(id),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpGet("getOrderCount")]
        public ResponseData GetOrderCount()
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetOrderCount()
            };
            return result;
        }


        /// <summary>
        /// download btob document
        /// </summary>
        /// <param name="id"> id btob document to download </param>
        /// <returns></returns>
        [HttpGet("downloadBtoBReport/{id}/{printType}"), Authorize(Roles = "PRINT")]
        public async Task<ResponseData> DownloadBtoBReport(int id, int printType)
        {
            ResponseData responseData = new ResponseData();
            if (id != 0)
            {
                if (_service == null)
                {
                    _service = (IServiceDocument)_serviceProvider.GetService(typeof(IServiceDocument));
                }
                GetUserMail();
                _serviceJasperReporting = (IServiceJasperReporting)_serviceProvider.GetService(typeof(IServiceJasperReporting));
                dynamic apiParams = new ExpandoObject();
                apiParams.report_documentId = id;
                DownloadReportDataViewModel data = new DownloadReportDataViewModel()
                {
                    Id = id,
                    ReportName = "genericDocumentReport",
                    PrintType = printType,
                    ReportFormatName = "pdf",
                    Reportparameters = JsonConvert.SerializeObject(apiParams)
                };
                data.Reportparameters = JsonConvert.DeserializeObject(data.Reportparameters);
                _service.UpdateReportSettings(data);
                responseData.objectData = await _serviceJasperReporting.ExecuteJasperReport(data, userMail);

                return responseData;



            }
            return responseData;
        }

        [HttpPost("getBalancedList")]
        public ResponseData GetBalancedList([FromBody] int idTiers)
        {

            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetBalancedList(idTiers, DocumentEnumerator.SalesDelivery, DocumentEnumerator.SalesOrder, true),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpPost("cancelBalancedDocLine")]
        public ResponseData CancelBalancedDocLine([FromBody] int idDocLine)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.CancelBalancedDocLine(idDocLine, DocumentEnumerator.SalesDelivery
                   , DocumentEnumerator.SalesOrder, true),
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpPost("saveCurrentDocument")]
        public virtual ResponseData SaveCurrentDocument([FromBody] DocumentViewModel document)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            var user = _serviceUser.GetModelAsNoTracked(y => y.Email == document.UserMail);
            document.IdTiers = user.IdTiers;
            var documentResponse = _serviceDocument.SaveOrder(document);
            result.objectData = _serviceDocument.GetDocumentForB2b(documentResponse.Id);
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.flag = 1;
            return result;
        }
        [HttpPost("getVehiculeBrand")]
        public ResponseData GetVehiculeBrand([FromBody] dynamic response)
        {
            string stringData = response.ToString();
            SynchronizeBtoBItemsViewModel responseSynchronizedItems = JsonConvert.DeserializeObject<SynchronizeBtoBItemsViewModel>(stringData);
            DateTime SearchDate = responseSynchronizedItems.searchDate;
            string connectionString = _serviceDocument.GetBTobConnectionString();
            ResponseData result = new ResponseData
            {
                objectData = _serviceBToBShared.GetVehiculeBrand(SearchDate, connectionString),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpPost("getFamilyList")]
        public ResponseData GetFamilyList([FromBody] dynamic response)
        {
            string stringData = response.ToString();
            SynchronizeBtoBItemsViewModel responseSynchronizedItems = JsonConvert.DeserializeObject<SynchronizeBtoBItemsViewModel>(stringData);
            DateTime SearchDate = responseSynchronizedItems.searchDate;
            string connectionString = _serviceDocument.GetBTobConnectionString();
            ResponseData result = new ResponseData
            {
                objectData = _serviceBToBShared.GetFamilyList(SearchDate, connectionString),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }

        [HttpPost("getModelOfItemList")]
        public ResponseData GetModelOfItemList([FromBody] dynamic response)
        {
            string stringData = response.ToString();
            SynchronizeBtoBItemsViewModel responseSynchronizedItems = JsonConvert.DeserializeObject<SynchronizeBtoBItemsViewModel>(stringData);
            DateTime SearchDate = responseSynchronizedItems.searchDate;
            string connectionString = _serviceDocument.GetBTobConnectionString();
            ResponseData result = new ResponseData
            {
                objectData = _serviceBToBShared.GetModelOfItemList(SearchDate, connectionString),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }
        [HttpPost("getSubModelList")]
        public ResponseData GetSubModelList([FromBody] dynamic response)
        {
            string stringData = response.ToString();
            SynchronizeBtoBItemsViewModel responseSynchronizedItems = JsonConvert.DeserializeObject<SynchronizeBtoBItemsViewModel>(stringData);
            DateTime SearchDate = responseSynchronizedItems.searchDate;
            string connectionString = _serviceDocument.GetBTobConnectionString();
            ResponseData result = new ResponseData
            {
                objectData = _serviceBToBShared.GetSubModelList(SearchDate, connectionString),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }
        [HttpPost("saveCurrentDocuments")]
        public virtual ResponseData SaveCurrentDocuments([FromBody] List<DocumentViewModel> documentList)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _serviceDocument.SaveBulkOrder(documentList);
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.flag = 1;
            return result;
        }

        [HttpPost("getPictureForBtoB")]
        public IList<SynchronizeBtobPicturesViewModel> getPictureForBtoB([FromBody] List<int> listOfIds)
        {
            return _serviceItem.GetFilesContentsForBtoB(listOfIds);
        }
        [HttpPost("getSubFamilyList")]
        public ResponseData GetSubFamilyList([FromBody] dynamic response)
        {
            string stringData = response.ToString();
            SynchronizeBtoBItemsViewModel responseSynchronizedItems = JsonConvert.DeserializeObject<SynchronizeBtoBItemsViewModel>(stringData);
            DateTime SearchDate = responseSynchronizedItems.searchDate;
            string connectionString = _serviceDocument.GetBTobConnectionString();
            ResponseData result = new ResponseData
            {
                objectData = _serviceBToBShared.GetSubFamilyList(SearchDate, connectionString),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }
        [HttpPost("getProductItemList")]
        public ResponseData GetProductItemList([FromBody] dynamic response)
        {
            string stringData = response.ToString();
            SynchronizeBtoBItemsViewModel responseSynchronizedItems = JsonConvert.DeserializeObject<SynchronizeBtoBItemsViewModel>(stringData);
            DateTime SearchDate = responseSynchronizedItems.searchDate;
            string connectionString = _serviceDocument.GetBTobConnectionString();
            ResponseData result = new ResponseData
            {
                objectData = _serviceBToBShared.GetProductItemList(SearchDate, connectionString),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }
        [HttpPost("CanceledOrderBtob")]
        public virtual ResponseData CanceledOrderBtob([FromBody] dynamic response  )
        {
            string stringData = response.ToString();
            CanceledOrderBtobViewModel codeFromBtob = JsonConvert.DeserializeObject<CanceledOrderBtobViewModel>(stringData);
            ResponseData result = new ResponseData();
            Document res = _serviceDocument.CanceledOrderFromBtob(codeFromBtob.Code);
            if (res != null) {
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.flag = 1;
            }else
            {
                result.customStatusCode = CustomStatusCode.UpdateNotExistingRoleCode;
                result.flag = 1;
            }
            return result;
        }

    }

}
