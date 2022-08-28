using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Sales.Interfaces;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Sales;
using Web.Controllers.GenericController;
using Web.Controllers.Sales.Interfaces;

namespace Web.Controllers.Sales.Classes
{

    [Route("api/documentExpenseLine")]
    public class DocumentExpenseLineController : BaseController, IDocumentExpenseLineController
    {
        private readonly IServiceDocumentExpenseLine _serviceDocumentExpenseLine;

        public DocumentExpenseLineController(IServiceProvider serviceProvider, ILogger<BaseController> logger,
            IServiceDocumentExpenseLine serviceDocumentExpenseLine)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            module = "";
            _serviceDocumentExpenseLine = serviceDocumentExpenseLine;
        }

        [HttpPost("calculateTtcAmount")]
        [AllowAnonymous]
        public ResponseData GetSpecificPrice([FromBody] DocumentExpenseLineViewModel documentExpenseLineController)
        {
            ResponseData result = new ResponseData();
            if (documentExpenseLineController != null)
            {
                result.flag = 1;
                result.objectData = _serviceDocumentExpenseLine.CalculateTTCAmount(documentExpenseLineController);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }

        [HttpPost("CalculateTotalExpose"), Authorize("SHOW_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,ADD_RECEIPT_PURCHASE")]
        public ResponseData CalculateTotalExpose([FromBody] TotalLineExpenseViewModel exponseData)
        {
            ResponseData result = new ResponseData();
            if (exponseData != null && exponseData.ExposeLines.Count > 0)
            {
                result.flag = 1;
                result.objectData = _serviceDocumentExpenseLine.CalculateTotalExpose(exponseData);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }

        [HttpPost("calculateCoefficientOfCostPrice")]
        public ResponseData CalculateCostPrice([FromBody] InputToCalculateCoefficientOfPriceCostViewModel priceCost)
        {
            ResponseData result = new ResponseData();
            if (priceCost != null)
            {
                result.objectData = _serviceDocumentExpenseLine.CalculateCoefficientOfCostPrice(priceCost);
            }
            return result;
        }

        [HttpPost("calculatePercentageCostPrice"), Authorize("UPDATE_RECEIPT_PURCHASE,ADD_RECEIPT_PURCHASE")]
        public ResponseData CalculatePercentageCostPrice([FromBody] InputToCalculateCoefficientOfPriceCostViewModel priceCost)
        {
            ResponseData result = new ResponseData();
            if (priceCost != null)
            {
                result.objectData = _serviceDocumentExpenseLine.CalculatePercentageCostPrice(priceCost);
            }
            return result;
        }

        [HttpPost("calculateCostPricePercentage"), Authorize("UPDATE_RECEIPT_PURCHASE,ADD_RECEIPT_PURCHASE")]
        public ResponseData CalculateCostPricePercentage([FromBody] InputToCalculateCoefficientOfPriceCostViewModel priceCost)
        {
            ResponseData result = new ResponseData();
            if (priceCost != null)
            {
                result.objectData = _serviceDocumentExpenseLine.CalculateCostPricePercentage(priceCost);
            }
            return result;
        }
    }
}
