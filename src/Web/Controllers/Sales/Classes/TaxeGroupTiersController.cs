using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Sales.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/taxeGroupTiers")]
    public class TaxeGroupTiersController : BaseController
    {
        private readonly IServiceTaxeGroupTiers _serviceTaxeGroupTiers;
        public TaxeGroupTiersController(IServiceProvider serviceProvider, ILogger<TaxeGroupTiersController> logger, IServiceTaxeGroupTiers serviceTaxeGroupTiers)
          : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _serviceTaxeGroupTiers = serviceTaxeGroupTiers;
        }
        [HttpGet("get"), Authorize("ADD_CUSTOMER,UPDATE_CUSTOMER,SHOW_CUSTOMER,ADD_SUPPLIER,UPDATE_SUPPLIER,LIST_CUSTOMER,SHOW_SUPPLIER,SHOW_SUPPLIER,UPDATE_PRICES,ADD_PRICES,SHOW_PRICES,LIST_SUPPLIER,LIST_CUSTOMER")]
        public override ResponseData Get()
        {
            return base.Get();
        }
        [HttpPost("getDataSourcePredicate"), Authorize("ADD_GROUP_TAX,UPDATE_GROUP_TAX,SHOW_GROUP_TAX,LIST_GROUP_TAX,GENERATE_BILLING_SESSION_INVOICES")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("getModelByCondition"), Authorize("ADD_GROUP_TAX,UPDATE_GROUP_TAX,SHOW_GROUP_TAX")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }
        [HttpPost("insert"), Authorize("ADD_GROUP_TAX")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }
        [HttpPut("update"), Authorize("UPDATE_GROUP_TAX")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
        [HttpDelete("delete/{id}"), Authorize("DELETE_GROUP_TAX")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
