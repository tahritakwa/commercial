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
    [Route("api/reviewFormation")]
    public class ReviewFormationController : BaseController
    {
        private readonly IServiceReviewFormation _serviceReviewFormation;
        public ReviewFormationController(IServiceProvider serviceProvider, ILogger<ReviewFormationController> logger,
            IServiceReviewFormation serviceReviewFormation)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceReviewFormation = serviceReviewFormation;
        }

        /// <summary>
        /// DeleteReviewFormationModel
        /// </summary>
        /// <param name="id"></param>
        /// <param name="hasRight"></param>
        /// <returns></returns>
        [HttpDelete("deleteReviewFormationModel/{hasRight}/{id}"), Authorize("DELETE_REVIEWFORMATION")]
        public ResponseData DeleteReviewFormationModel(int id, bool hasRight)
        {
            GetUserMail();
            ResponseData result = new ResponseData();

            _serviceReviewFormation.DeleteReviewFormationModelwithouTransaction(id, modelName, userMail, hasRight);
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