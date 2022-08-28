using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/employeeTeam")]
    public class EmployeeTeamController : BaseController
    {
        private readonly IServiceEmployeeTeam _serviceEmployeeTeam;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        /// <param name="serviceEmployeeTeam"></param>
        public EmployeeTeamController(IServiceProvider serviceProvider, ILogger<EmployeeTeamController> logger, IServiceEmployeeTeam serviceEmployeeTeam)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceEmployeeTeam = serviceEmployeeTeam;
        }


        [HttpGet, Route("getTeamResources/{idTeam}"), Authorize("LIST_TEAM,ADD_TEAM")]
        public ResponseData GetEmployeeFreeResources(int idTeam)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceEmployeeTeam.GetTeamResources(idTeam),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }



        [HttpPost, Route("getAssignationtHistoric/{idTeam}/{idEmployee}"), Authorize("LIST_TEAM")]
        public ResponseData GetAssignationtHistoric([FromBody] PredicateFormatViewModel predicate, int idTeam, int idEmployee)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _serviceEmployeeTeam.GetAssignationtHistoric(idTeam, idEmployee);
                result.listObject = new ListObject
                {
                    listData = dataSourceResult
                };
                result.objectData = _serviceEmployeeTeam.GetModelByConditionWithHistory(predicate);
            }
            return result;
        }

        [HttpPost("validateConditionAssignmentPercentage"), Authorize("LIST_TEAM,UPDATE_TEAM")]
        public ResponseData ValidateConditionAssignmentPercentage([FromBody] EmployeeTeamViewModel employeeTeam)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                _serviceEmployeeTeam.ValidateConditionAssignmentPercentage(employeeTeam);
                result.flag = NumberConstant.One;
            }
            return result;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_EMPLOYEE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPut("update"), Authorize("UPDATE_TEAM")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
    }
}
