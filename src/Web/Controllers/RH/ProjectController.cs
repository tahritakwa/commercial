using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.RH.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/project")]
    public class ProjectController : BaseController
    {
        private readonly IServiceProject _serviceProject;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        /// <param name="serviceTimeSheet"></param>
        public ProjectController(IServiceProvider serviceProvider, ILogger<TimeSheetController> logger, IServiceProject serviceProject)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProject = serviceProject;
        }

        /// <summary>
        /// Retrieve the employee's timeSheet as a parameter for the current month. If the employee has already returned one
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        [HttpPost("getEmployeeProject"), Authorize("LIST_PROJECT")]
        public IList<ProjectViewModel> GetEmployeeTimeSheet([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave.model.IdEmployee != null && objectToSave.model.StartDate != null)
            {
                DateTime startDate = objectToSave.model.StartDate.Value;
                DateTime endDate = startDate.AddMonths(NumberConstant.One).AddDays(-NumberConstant.One);
                return _serviceProject.EmployeeAssignedProjectAtDate((int)objectToSave.model.IdEmployee, startDate, endDate);
            }
            return new List<ProjectViewModel>();
        }

        /// <summary>
        /// Retrieve the employee's timeSheet as a parameter for the current month and return employee's worked projects in a specific month
        /// </summary>
        /// <param name="idEmployee"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        [HttpPost("getEmployeeWorkedProject")]
        public IList<ProjectViewModel> GetEmployeeWorkedProject([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave.model.IdEmployee != null && objectToSave.model.StartDate != null)
            {
                DateTime startDate = objectToSave.model.StartDate.Value;
                DateTime endDate = startDate.AddMonths(NumberConstant.One).AddDays(-NumberConstant.One);
                return _serviceProject.EmployeeWorkedProjectAtDate((int)objectToSave.model.IdEmployee, startDate, endDate);
            }
            return new List<ProjectViewModel>();
        }

        [HttpPost("getProjectDropdownForBillingSession"), Authorize("LIST_PROJECT")]
        public ResponseData GetProjectDropdownForBillingSession([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicateFormatViewModel = new PredicateFormatViewModel();
            ResponseData result = new ResponseData();
            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            DateTime month = objectToSave.model.month;
            var dataSource = _serviceProject.GetProjectDropdownForBillingSession(predicateFormatViewModel, month);
            result.listObject = new ListObject
            {
                listData = dataSource.data,
                total = dataSource.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpPost("getModelByConditionWithHistory"), Authorize("ADD_SERVICES_CONTRACT,UPDATE_SERVICES_CONTRACT,SHOW_SERVICES_CONTRACT")]
        public ResponseData GetModelByConditionWithHistory([FromBody] PredicateFormatViewModel predicate)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            ResponseData result = new ResponseData
            {
                objectData = _serviceProject.GetModelByConditionWithHistory(predicate),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;

        }

        [HttpPost("getFiltredProjectList"), Authorize("LIST_SERVICES_CONTRACT")]
        public ResponseData GetFiltredProjectList([FromBody] ObjectToSaveViewModel objectSaved)
        {
            PredicateFormatViewModel predicateFormatViewModel = null;
            DateTime? startDate = null;
            DateTime? endDate = null;
            if (objectSaved.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectSaved.model.predicate.ToString());
            }
            if (objectSaved.model.startDate != null)
            {
                startDate = objectSaved.model.startDate;
            }
            if (objectSaved.model.endDate != null)
            {
                endDate = objectSaved.model.endDate;
            }
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceProject.GetFiltredProjectList(predicateFormatViewModel, endDate, startDate),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }
        [HttpPost("getUnicity"), Authorize("ADD_SERVICES_CONTRACT,UPDATE_SERVICES_CONTRACT,SHOW_SERVICES_CONTRACT")]
        public override bool GetUnicity([FromBody] dynamic objectToCheck)
        {
            return base.GetUnicity((object)objectToCheck);
        }

        [HttpPost("insert"), Authorize("ADD_SERVICES_CONTRACT")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {

            return base.Post(files, objectSaved, objectJsonToSave);

        }
        [HttpPut("update"), Authorize("UPDATE_SERVICES_CONTRACT")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }

        [HttpDelete("delete/{id}"), Authorize("DELETE_SERVICES_CONTRACT")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
