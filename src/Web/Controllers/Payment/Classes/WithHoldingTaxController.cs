using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;

namespace Web.Controllers.Payment.Classes
{
    [Route("api/withholdingTax")]
    public class WithHoldingTaxController : BaseController
    {
        public WithHoldingTaxController(IServiceProvider serviceProvider, ILogger<WithHoldingTaxController> logger)
          : base(serviceProvider, logger)
        {
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_WITHHOLDING_TAX,SHOW_WITHHOLDING_TAX,SHOW_INVOICE_PURCHASE,UPDATE_INVOICE_SALES,SHOW_INVOICE_SALES,ADD_INVOICE_PURCHASE,UPDATE_INVOICE_PURCHASE,ADD_INVOICE_SALES")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpGet("getById/{id}"), Authorize("LIST_WITHHOLDING_TAX,UPDATE_WITHHOLDING_TAX,SHOW_WITHHOLDING_TAX")]
        public override ResponseData GetById(int id)
        {
            return base.GetById(id);
        }

        [HttpPost("insert"), Authorize("ADD_WITHHOLDING_TAX")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }

        [HttpDelete("delete/{id}"), Authorize("DELETE_WITHHOLDING_TAX")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }

        [HttpPut("update"), Authorize("UPDATE_WITHHOLDING_TAX")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
    }
}
