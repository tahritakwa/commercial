using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.RH.Interfaces;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/reviewSkills")]
    public class ReviewSkillsController : BaseController
    {
        private readonly IServiceReviewSkills _serviceReviewSkills;
        public ReviewSkillsController(IServiceProvider serviceProvider, ILogger<ObjectiveController> logger,
            IServiceObjective serviceObjective,
            IServiceReviewSkills serviceReviewSkills)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceReviewSkills = serviceReviewSkills;
        }

        /// <summary>
        /// DeleteReviewSkillsModel
        /// </summary>
        /// <param name="id"></param>
        /// <param name="hasRight"></param>
        /// <returns></returns>
        [HttpDelete("deleteReviewSkillsModel/{hasRight}/{id}"), Authorize("DELETE_REVIEWSKILLS")]
        public ResponseData DeleteReviewSkillsModel(int id, bool hasRight)
        {
            GetUserMail();
            ResponseData result = new ResponseData();

            _serviceReviewSkills.DeleteReviewSkillsModelwithouTransaction(id, modelName, userMail, hasRight);
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.DeleteSuccessfull;

            return result;
        }
        [HttpPost("getDataSourcePredicate"), Authorize("SHOW_REVIEW")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
