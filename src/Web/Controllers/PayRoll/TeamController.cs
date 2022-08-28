using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/team")]
    public class TeamController : BaseController
    {
        private readonly IServiceTeam _serviceTeam;

        public TeamController(IServiceProvider serviceProvider, ILogger<TeamController> logger
            , IServiceTeam serviceTeam)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceTeam = serviceTeam;
        }

        [HttpPost, Route("getTeamsByFilter"), Authorize("LIST_TEAM")]
        public ResponseData GetTeamsByFilter([FromBody] PredicateFormatViewModel predicate)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _serviceTeam.GetTeamsByFilter(predicate);
                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }

        [HttpGet, Route("getTeamDropdown"), Authorize("LIST_TEAM,ADD_TRAININGSESSION,UPDATE_TRAININGSESSION,LIST_TRAININGREQUEST,LIST_TIMESHEET,SHOW_TRAINING_SESSION,ALL_TRAINING_REQUEST")]
        public ResponseData GetTeamDropdown()
        {
            GetUserMail();
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _serviceTeam.GetEmployeeTeamDropdown(userMail),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("getModelByConditionWithHistory"), Authorize("SHOW_TEAM")]
        public ResponseData GetModelByConditionWithHistory([FromBody] PredicateFormatViewModel predicate)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            ResponseData result = new ResponseData
            {
                objectData = _serviceTeam.GetModelByConditionWithHistory(predicate),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };
            return result;
        }

        /// <summary>
        /// Returns the list of teams whose team type label is the type in parameter
        /// </summary>
        /// <param name="labelTeamType"></param>
        /// <returns></returns>
        [HttpGet("getTeamsByType/{labelTeamType}"), Authorize("LIST_TEAM")]
        public ResponseData GetConnectedUserRoles(string labelTeamType)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceTeam.FindModelsByNoTracked(x => x.IdTeamTypeNavigation.Label.ToUpper().Equals(labelTeamType.ToUpper()))
            };
            return result;
        }

        /// <summary>
        /// Returns the list of employees associated with one team having as a type code one of the types in parameter
        /// </summary>
        /// <param name="labelTeamTypes"></param>
        /// <returns></returns>
        [HttpPost("getEmployeesOfTeamType"), Authorize("LIST_TEAM,ADD_CATEGORY,EDIT_CATEGORY,VIEW_ACTION,ADD_ACTION,EDIT_ACTION,OWN_ACTION,OWN_CONTACT,EDIT_CONTACT,OWN_ORGANISATION,EDIT_ORGANISATION,VIEW_LEAVE," +
            "EDIT_OPPORTUNITY,OWN_OPPORTUNITY,VIEW_ARCHIVED_ACTION")]
        public ResponseData GetEmployeesOfTeamType([FromBody] IList<string> labelTeamTypes)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceTeam.GetEmployeesOfTeamTypes(labelTeamTypes)
            };
            return result;
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_LEAVE,ADD_LEAVEREQUEST,LIST_TRAININGREQUEST,LIST_TIMESHEET,LIST_EXPENSEREPORT,LIST_DOCUMENTREQUEST,ALL_TRAINING_REQUEST")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpGet("getDataDropdown"), Authorize("ADD_CONTACT,ADD_ORGANISATION,LIST_LEAVE,VIEW_SKILLS_MATRIX,ADD_OPPORTUNITY,EDIT_OPPORTUNITY,OWN_OPPORTUNITY")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
    }
}
