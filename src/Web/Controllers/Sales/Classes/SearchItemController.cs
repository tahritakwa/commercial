using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.Sales.Interfaces;
using System;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Sales;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/searchItem")]
    public class SearchItemController : BaseController
    {
        private readonly IServiceSearchItem _serviceSearchItem;
        public SearchItemController(IServiceProvider serviceProvider, ILogger<BaseController> logger, IServiceSearchItem serviceSearchItem)
          : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _serviceSearchItem = serviceSearchItem;
        }

        [HttpPost("addSearch")]
        public async Task<ResponseData> AddSearch([FromBody] SearchItemObjectToSaveViewModel searchItemSupplierViewModel)
        {
            GetUserMail();
            _serviceSearchItem.AddSearch(searchItemSupplierViewModel, userMail);
            ResponseData result = new ResponseData
            {
                flag = 1
            };
            return result;
        }
        [HttpPost("getSearchedSuppliers"), Authorize("RESEARCH_HISTORY")]
        public ResponseData GetSearchedSuppliers([FromBody] PredicateFormatViewModel predicateFormatViewModel)
        {
            ResponseData result = new ResponseData
            {
                flag = 2,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            int total = 0;
            result.listObject = new ListObject
            {
                listData = _serviceSearchItem.GetSearchedSuppliers(predicateFormatViewModel, out total),
                total = total
            };
            return result;
        }
        [HttpPost("getSerachDetailPeerSupplier"), Authorize("RESEARCH_HISTORY")]
        public ResponseData GetSerachDetailPeerSupplier([FromBody] PredicateFormatViewModel predicateFormatViewModel)
        {
            ResponseData result = new ResponseData
            {
                flag = 2,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            int total = 0;
            result.listObject = new ListObject
            {
                listData = _serviceSearchItem.GetSerachDetailPeerSupplier(predicateFormatViewModel, out total),
                total = total
            };
            return result;
        }
        [HttpPost("generateDocument"), Authorize("ADD_DELIVERY_SALES,UPDATE_DELIVERY_SALES")]
        public ResponseData GenerateDocument([FromBody] SearchItemToGenerateDocViewModel searchItemToGenerateDocViewModel)
        {
            GetUserMail();
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceSearchItem.GenerateDocument(searchItemToGenerateDocViewModel, userMail),
                customStatusCode = CustomStatusCode.DocumentAddedsuccessfully
            };

            return result;
        }

        [HttpPost("insertUpdateDocumentLine"), Authorize("SHOW_DELIVERY_SALES,,ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,COUNTER_SALES")]
        public ResponseData InsertUpdateDocumentLine([FromBody] SearchItemToGenerateDocViewModel searchItemToGenerateDocViewModel)
        {
            _serviceSearchItem.AddItemToDocument(searchItemToGenerateDocViewModel);
            ResponseData result = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.LineAddedsuccessfully
            };

            return result;
        }

        [HttpPost("tiersDetails/{idTiers}"), Authorize("LIST_QUICK_SALES,ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,COUNTER_SALES")]
        public ResponseData TiersDetails(int idTiers)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceSearchItem.TiersDetails(idTiers),
                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };

            return result;
        }

        [HttpPost("checkRealAndProvisionalStock"), Authorize("SHOW_DELIVERY_SALES," +
            "ADD_ORDER_QUOTATION_PURCHASE,UPDATE_ORDER_QUOTATION_PURCHASE,ADD_QUOTATION_SALES,ADD_ORDER_SALES,ADD_DELIVERY_SALES,ADD_INVOICE_SALES,ADD_ASSET_SALES," +
            "ADD_INVOICE_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINAL_ORDER_PURCHASE,ADD_FINAL_ORDER_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE," +
            "UPDATE_QUOTATION_SALES,ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,UPDATE_FINANCIAL_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,UPDATE_VALID_ORDER_SALES,UPDATE_ORDER_SALES," +
            "UPDATE_ASSET_SALES,UPDATE_VALID_ASSET_SALES,UPDATE_INVOICE_SALES,ADD_ADMISSION_VOUCHERS,ADD_EXIT_VOUCHERS,UPDATE_DELIVERY_SALES,UPDATE_VALID_DELIVERY_SALES,COUNTER_SALES")]
        public ResponseData CheckRealAndProvisionalStock([FromBody] SearchItemToGenerateDocViewModel searchItemToGenerateDocViewModel)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceSearchItem.CheckRealAndProvisionalStock(searchItemToGenerateDocViewModel),
                flag = 1,
                customStatusCode = CustomStatusCode.GetSuccessfull
            };

            return result;
        }
        [HttpPost("isValidDocument/{idDocument}")]
        public ResponseData IsValidDocument([FromRoute] int idDocument)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceSearchItem.IsValidDocument(idDocument)
            };
            return result;
        }


    }
}
