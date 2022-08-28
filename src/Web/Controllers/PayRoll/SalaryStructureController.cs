using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Linq;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/salaryStructure")]
    public class SalaryStructureController : BaseController
    {
        private readonly IServiceSalaryStructure _serviceSalaryStructure;
        public SalaryStructureController(IServiceProvider serviceProvider, ILogger<SalaryStructureController> logger,
            IServiceSalaryStructure serviceSalaryStructure)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceSalaryStructure = serviceSalaryStructure;
        }

        [HttpPost("getSalaryStructureWithSalaryRules"), Authorize("ADD_SALARYSTRUCTURE,SHOW_SALARYSTRUCTURE")]
        public ResponseData GetSalaryStructureWithSalaryRules([FromBody] int idSalaryStructure)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceSalaryStructure.GetSalaryStructureWithSalaryRules(idSalaryStructure),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("checkIfSalaryStructureIsAssociatedWithAnyPayslip"), Authorize("ADD_SALARYSTRUCTURE,UPDATE_SALARYSTRUCTURE")]
        public bool CheckIfSalaryStructureIsAssociatedWithAnyPayslip([FromBody] SalaryStructureViewModel model)
        {
            return _serviceSalaryStructure.CheckIfSalaryStructureIsAssociatedWithAnyPayslip(model).Any();
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_EMPLOYEE,LIST_CONTRACT,ADD_RECRUITMENT,FULL_RECRUITMENT,LIST_SALARYSTRUCTURE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
