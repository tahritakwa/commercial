using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.RH.Interfaces;
using Services.Specific.Sales.Interfaces;
using Settings.Exceptions;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/employeeProject")]
    public class EmployeeProjectController : BaseController
    {
        private readonly IServiceEmployeeProject _serviceEmployeeProject;
        private readonly IServiceBillingSession _serviceBillingSession;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        /// <param name="serviceEmployeeProject"></param>
        public EmployeeProjectController(IServiceProvider serviceProvider, ILogger<EmployeeProjectController> logger,
            IServiceEmployeeProject serviceEmployeeProject, IServiceBillingSession serviceBillingSession)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceEmployeeProject = serviceEmployeeProject;
            _serviceBillingSession = serviceBillingSession;
        }


        [HttpGet, Route("getProjectResources/{idProject}"), Authorize("LIST_EMPLOYEEPROJECT,ADD_SERVICES_CONTRACT,SHOW_SERVICES_CONTRACT,UPDATE_SERVICES_CONTRACT")]
        public ResponseData GetEmployeeFreeResources(int idProject)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceEmployeeProject.GetProjectResources(idProject),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

     

        [HttpGet, Route("getAssignationtHistoric/{idProject}/{idEmployee}"), Authorize("LIST_EMPLOYEEPROJECT")]
        public ResponseData GetAssignationtHistoric(int idProject, int idEmployee)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _serviceEmployeeProject.GetAssignationtHistoric(idProject, idEmployee);
            }
            return result;
        }
    }
}
