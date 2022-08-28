using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Sales.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Sales;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/documentWithholdingTax")]
    public class DocumentWithholdingTaxController : BaseController
    {
        readonly IServiceDocumentWithholdingTax _serviceDocumentWithholdingTax;
   
        public DocumentWithholdingTaxController(
            IServiceProvider serviceProvider,
            ILogger<DocumentWithholdingTaxController> logger,
            IServiceDocumentWithholdingTax serviceDocumentWithholdingTax)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceDocumentWithholdingTax = serviceDocumentWithholdingTax;
            
        }

        [HttpPost, Route("addDocumentsWithholdingTax"), Authorize("ADD_PURCHASE_WITHHOLDING_TAX,ADD_SALES_WITHHOLDING_TAX")]
        public ResponseData AddDocumentWithholdingTax([FromBody] List<DocumentWithholdingTaxViewModel> model)
        {

            GetUserMail();
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocumentWithholdingTax.AddDocumentWithholdingTax(model, userMail),
                flag = 1,
                customStatusCode = CustomStatusCode.AddSuccessfull
            };
           
            return result;
        }

        [HttpPost, Route("getAllDocumentsWithholdingTax")]
        public ResponseData GetAllDocumentsWithholdingTax([FromBody] PredicateFormatViewModel model)
        {

            ResponseData result = new ResponseData
            {
                objectData = _serviceDocumentWithholdingTax.FindDataSourceModelBy(model),
                flag = 1,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };

            return result;
        }
    }
}
