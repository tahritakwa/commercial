using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/job")]
    public class JobController : BaseController
    {
        private readonly IServiceJob _serviceJob;
        private readonly IServiceEmployee _serviceEmployee;

        public JobController(IServiceProvider serviceProvider, ILogger<TeamController> logger
            , IServiceJob serviceJob, IServiceEmployee serviceEmployee)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceJob = serviceJob;
            _serviceEmployee = serviceEmployee;
        }

        /// <summary>
        /// Get job list with jobs children
        /// </summary>
        /// <returns></returns>
        [HttpGet("getJobList"), Authorize("LIST_JOB")]
        public ResponseData GetJobList()
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.listObject = new ListObject
                {
                    listData = _serviceJob.GetListOfJobs()
                };
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
            }
            return result;
        }

        /// <summary>
        /// Synchronize jobs
        /// </summary>
        /// <returns></returns>
        [HttpPost("synchronizeJobs"), Authorize("LIST_JOB")]
        public bool SynchronizeJobs()
        {
            _serviceJob.SynchronizeJobs();
            return true;
        }

        [HttpGet("getDataDropdown"), Authorize("LIST_EMPLOYEE,SHOW_REVIEW")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_RECRUITMENTREQUEST,LIST_RECRUITMENTOFFER,ADD_RECRUITMENTREQUEST,ADD_RECRUITMENTOFFER,UPDATE_RECRUITMENTREQUEST,UPDATE_RECRUITMENTOFFER," +
            "LIST_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT,ADD_EMPLOYEE,UPDATE_EMPLOYEE")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
    }
}
