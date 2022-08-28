using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Sales.Interfaces;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/financialCommitment")]
    public class FinancialCommitmentController : BaseController
    {
        private readonly IServiceFinancialCommitment _serviceFinancialCommitment;
        public FinancialCommitmentController(IServiceProvider serviceProvider, ILogger<BaseController> logger,
            IServiceFinancialCommitment serviceFinancialCommitment)
            : base(serviceProvider, logger)
        {
            _serviceFinancialCommitment = serviceFinancialCommitment;
        }

        [HttpGet("getFinancialCommitmentOfCurrentDocument/{id}"), Authorize("UPDATE_INVOICE_PURCHASE,SHOW_INVOICE_PURCHASE,ADD_INVOICE_PURCHASE,ADD_ASSET_PURCHASE,UPDATE_ASSET_PURCHASE,SHOW_ASSET_PURCHASE," +
            "SHOW_FINANCIAL_ASSET_SALES,ADD_FINANCIAL_ASSET_SALES,UPDATE_FINANCIAL_ASSET_SALES,SHOW_INVOICE_ASSET_SALES,ADD_INVOICE_ASSET_SALES,UPDATE_INVOICE_ASSET_SALES,SHOW_INVOICE_SALES,UPDATE_INVOICE_SALES," +
            "ADD_INVOICE_SALES")]
        public virtual ResponseData GetFinancialCommitmentOfCurrentDocument(int id)
        {

            var dataSourceResult = _serviceFinancialCommitment.GetFinancialCommitmentOfCurrentDocument(id);
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = dataSourceResult,
                    total = dataSourceResult.Count
                },
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull,
                flag = 2
            };
            return result;

        }

        [HttpPost("isDcoumentHaveOnlyDepositSettlement"), Authorize("LIST_INVOICE_SALES")]
        public bool IsValidDepositInvoiceStatus([FromBody] dynamic objectToCheck)
        {
            if (objectToCheck == null)
            {
                throw new ArgumentNullException(nameof(objectToCheck));
            }
            int idDoc = (int)objectToCheck.IdDocument;
            bool result = _serviceFinancialCommitment.isDcoumentHaveOnlyDepositSettlement(idDoc);
            return result;
        }
        


    }
}
