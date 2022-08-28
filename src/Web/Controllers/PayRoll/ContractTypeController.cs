using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/contractType")]
    public class ContractTypeController : BaseController
    {
        public ContractTypeController(IServiceProvider serviceProvider, ILogger<ContractTypeController> logger)
           : base(serviceProvider, logger)
        {
        }
        [HttpGet("getDataDropdown"), Authorize("LIST_CONTRACT,LIST_RECRUITMENTOFFER,LIST_RECRUITMENTREQUEST,FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT,ADD_EMPLOYEEEXIT,UPDATE_EMPLOYEEEXIT")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_CONTRACT,ADD_RECRUITMENTOFFER,UPDATE_RECRUITMENTOFFER,ADD_RECRUITMENTREQUEST,UPDATE_RECRUITMENTREQUEST,ADD_RECRUITMENT,UPDATE_RECRUITMENT," +
            "ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE,ADD_CONTRACT,ADD_EMPLOYEE,UPDATE_CONTRACT,UPDATE_EMPLOYEE,LIST_CONTRACT,SHOW_PAYROLL_SESSION,OPEN_PAYROLL_SESSION")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);

        }
    }
}
