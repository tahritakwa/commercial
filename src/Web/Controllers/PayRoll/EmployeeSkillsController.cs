using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.PayRoll.Interfaces;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/employeeSkills")]
    public class EmployeeSkillsController : BaseController
    {
        private readonly IServiceEmployeeSkills _serviceEmployeeSkills;

        public EmployeeSkillsController(IServiceProvider serviceProvider, ILogger<ExpenseReportController> logger,
            IServiceEmployeeSkills serviceEmployeeSkills)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceEmployeeSkills = serviceEmployeeSkills;
        }


        [HttpPost("getSkillsMatrix"), Authorize("LIST_EMPLOYEESKILLS,VIEW_SKILLS_MATRIX,LIST_SKILLS,ADD_CATEGORY,EDIT_CATEGORY")]
        public ResponseData GetSkillsMatrix([FromBody] EmployeeSkillsMatrixFilter employeeSkillsMatrixFilter)
        {
            DataSourceResult<EmployeeSkillsMatrixLine> matrix = _serviceEmployeeSkills.GetSkillsMatrix(employeeSkillsMatrixFilter);
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = matrix,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        [HttpPost("saveRating"), Authorize("ADD_EMPLOYEESKILLS,CHANGE_RANGE_SKILLS_MATRIX")]
        public ResponseData changeRating([FromBody] ObjectToSaveViewModel objectToSave)
        {
            EmployeeSkillsViewModel pricesViewModel = JsonConvert.DeserializeObject<EmployeeSkillsViewModel>(objectToSave.model.ToString());
            var objectData = _serviceEmployeeSkills.changeRating(pricesViewModel, objectToSave.EntityAxisValues, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.AddSuccessfull,
                objectData = objectData,
                flag = 1
            };
            return result;

        }

        /// <summary>
        /// Get the employee old skills, for the annual interview
        /// </summary>
        /// <param name="idReview"></param>
        /// <returns></returns>
        [HttpPost("getPastReviewSkillsList/{idReview}"), Authorize("LIST_EMPLOYEESKILLS,SHOW_REVIEW")]
        public ResponseData GetPastReviewSkillsList(int idReview)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceEmployeeSkills.GetPastReviewSkillsList(idReview);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }
    }
}
