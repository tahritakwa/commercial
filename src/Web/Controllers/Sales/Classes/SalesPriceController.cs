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
    [Route("api/salesPrice")]
    public class SalesPriceController : BaseController
    {
        public readonly IServiceSalesPrice _serviceSalesPrice;
        public SalesPriceController(IServiceProvider serviceProvider, IServiceSalesPrice serviceSalesPrice, ILogger<ExpenseController> logger)
          : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _serviceSalesPrice = serviceSalesPrice;
            _logger = logger;
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_PRICECATEGORY")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
        [HttpPost("insert"), Authorize("ADD_PRICECATEGORY")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }
        [HttpPut("update"), Authorize("UPDATE_PRICECATEGORY")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
        [HttpDelete("delete/{id}"), Authorize("DELETE_PRICECATEGORY")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }

        [HttpGet("getDataDropdown"), Authorize("LIST_PRICECATEGORY,ADD_CUSTOMER,UPDATE_CUSTOMER,UPDATE_PRICECATEGORY,ADD_PRICECATEGORY,SHOW_CUSTOMER,DETAILS_ITEM,ADD_ITEM,UPDATE_ITEM,ADD_ITEM_STOCK")]

        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }

        }
}
