using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/country")]
    public class CountryController : BaseController
    {
        public CountryController(IServiceProvider serviceProvider, ILogger<CountryController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpGet("getDataDropdown"), Authorize("LIST_EMPLOYEE,LIST_CANDIDATE,VIEW_ORGANISATION_LEAD,VIEW_ORGANISATION_CLIENT,ADD_ORGANISATION,DELETE_ORGANISATION,EDIT_ORGANISATION," +
            "OWN_ORGANISATION,SHOW_SUPPLIER,ADD_SUPPLIER,UPDATE_SUPPLIER,VIEW_CONTACT_LEAD,VIEW_CONTACT_CLIENT,VIEW_HISTORY_CONTACT,ADD_CONTACT,EDIT_CONTACT,OWN_CONTACT,ADD_CUSTOMER,SHOW_CUSTOMER,UPDATE_CUSTOMER,UPDATE_COMPANY,SHOW_COMPANY,ADD_OFFICE,UPDATE_OFFICE")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_EMPLOYEE,UPDATE_EMPLOYEE,ADD_CANDIDATE,UPDATE_COMPANY,UPDATE_CANDIDATE,SHOW_EMPLOYEE,LIST_TREASURY_BANK_ACCOUNT,SHOW_OFFICE,ADD_OFFICE,UPDATE_OFFICE," +
            "LIST_CUSTOMER,ADD_CUSTOMER,SHOW_CUSTOMER,ADD_CITY,UPDATE_CITY,SHOW_CITY,ADD_BANK,UPDATE_BANK,SHOW_BANK,LIST_SUPPLIER,LIST_CUSTOMER,SHOW_CANDIDATE,ADD_CASH_MANAGEMENT,UPDATE_CASH_MANAGEMENT")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpPost("getDataSourcePredicate"), Authorize("VIEW_ORGANISATION_LEAD, VIEW_ORGANISATION_CLIENT, VIEW_CONTACT_LEAD, VIEW_CONTACT_CLIENT, EDIT_ORGANISATION")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
