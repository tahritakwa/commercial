using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Reporting.Interfaces;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Reporting.Generic;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/taxe")]
    public class TaxeController : BaseController, ITaxeController
    {
        private readonly IServiceTaxe _serviceTaxe;
        private readonly IServiceJasperReporting _serviceJasperReporting;
        /// <summary>
        /// Initializes a new instance of the <see cref="BaseController"/> class.
        /// </summary>
        /// <param name="serviceProvider">The service provider.</param>
        public TaxeController(IServiceProvider serviceProvider, IServiceTaxe serviceTaxe, ILogger<TaxeController> logger, IServiceJasperReporting serviceJasperReporting)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceTaxe = serviceTaxe;
            _serviceJasperReporting = serviceJasperReporting;
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_ITEM,UPDATE_ITEM,DETAILS_ITEM")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }

        [HttpGet("getDataDropdown"), Authorize("ADD_RECEIPT_PURCHASE,UPDATE_RECEIPT_PURCHASE,ADD_EXPENSE,UPDATE_EXPENSE,ADD_OPERATIONS,UPDATE_OPERATIONS,SHOW_PURCHASE,UPDATE_COMPANY,SHOW_COMPANY,SHOW_EXPENSE,ADD_GROUP_TAX,UPDATE_GROUP_TAX" +
            ",ADD_SERVICES_CONTRACT,SHOW_SERVICES_CONTRACT,UPDATE_SERVICES_CONTRACT")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_TAX,ADD_TAX,UPDATE_TAX,SHOW_TAX")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
        [HttpPost("insert"), Authorize("ADD_TAX")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }
        [HttpPut("update"), Authorize("UPDATE_TAX")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
        [HttpDelete("delete/{id}"), Authorize("DELETE_TAX")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }
        [HttpPost("downloadJasperDocumentReport"), Authorize("PRINT_VAT_DECLARATION")]
        public override Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            return base.DownloadJasperDocumentReport(data);
        }
        [HttpPost("MultiPrintVatDeclarationJasper"), Authorize("PRINT_VAT_DECLARATION")]
        public async Task<ResponseData> MultiPrintVatDeclarationJasper([FromBody] DownloadReportDataViewModel data)
        {
            ResponseData responseData = new ResponseData();
            GetUserMailInvariant();
            _serviceTaxe.getUsedCurrency(data);
            responseData.objectData = await _serviceJasperReporting.ExecuteMultipleVatDeclarationReport(data, userMail);
            return responseData;
        }

    }
}
