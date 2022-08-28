using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/city")]
    public class CityController : BaseController
    {
        public CityController(IServiceProvider serviceProvider, ILogger<CityController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_EMPLOYEE,ADD_BANKACCOUNT,ADD_EMPLOYEE,UPDATE_COMPANY,UPDATE_COMPANY,SHOW_OFFICE,ADD_OFFICE,UPDATE_OFFICE,LIST_CUSTOMER,ADD_CUSTOMER,SHOW_CUSTOMER," +
            "LIST_SUPPLIER,ADD_SUPPLIER,SHOW_SUPPLIER,UPDATE_SUPPLIER,UPDATE_GARAGE,SHOW_GARAGE,ADD_GARAGE,SHOW_COMPANY,ADD_CASH_MANAGEMENT,UPDATE_CASH_MANAGEMENT,SHOW_EMPLOYEE,UPDATE_EMPLOYEE,"+
            "ADD_CONTACT,EDIT_CONTACT,EDIT_ORGANISATION,ADD_ORGANISATION")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpPost("getPictures"), Authorize("ADD_CITY,UPDATE_CITY,SHOW_CITY")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }
    }
}
