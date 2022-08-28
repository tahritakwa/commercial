using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Linq;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/benefitInKind")]
    public class BenefitInKindController : BaseController
    {
        private readonly IServiceBenefitInKind _serviceBenefitInKind;
        public BenefitInKindController(IServiceProvider serviceProvider,
           ILogger<BenefitInKindController> logger, IServiceBenefitInKind serviceBenefitInKind)
           : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceBenefitInKind = serviceBenefitInKind;
        }

        [HttpPost("checkIfBenefitInKindIsAssociatedWithAnyPayslip"), Authorize("UPDATE_BENEFITINKIND")]
        public bool CheckIfBenefitInKindsHasAnyPayslip([FromBody] BenefitInKindViewModel model)
        {
            return _serviceBenefitInKind.CheckIfBenefitInKindIsAssociatedWithAnyPayslip(model).Any();
        }

        [HttpGet("get"), Authorize("LIST_CONTRACT,ADD_RECRUITMENT,UPDATE_RECRUITMENT")]
        public override ResponseData Get()
        {
            return base.Get();
        }
        /// <summary>
        /// Gets this instance.
        /// </summary>
        /// <returns>
        /// ResponseData format that contains a message If an error occurs
        /// or the specific data if it's a successful process
        /// </returns>
        [HttpPost("get"), Authorize("LIST_CONTRACT,FULL_RECRUITMENT")]
        public override ResponseData Get([FromBody] PredicateFormatViewModel model)
        {
            return base.Get(model);
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_CONTRACT,ADD_EMPLOYEE,UPDATE_CONTRACT,UPDATE_EMPLOYEE")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
    }
}
