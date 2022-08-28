using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.RH.Interfaces;
using System;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.RH;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/review")]
    public class ReviewController : BaseController
    {
        private readonly IServiceReview _serviceReview;
        public ReviewController(IServiceProvider serviceProvider, ILogger<ReviewController> logger,
            IServiceReview serviceReview)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceReview = serviceReview;
        }

        [HttpGet, Route("getReviewWithHisNavigations/{id}"), Authorize("LIST_REVIEW,LIST_ANNUALINTERVIEW,UPDATE_ANNUALINTERVIEW")]
        public ResponseData GetRevieweWithHisNavigations(int id)
        {
            return new ResponseData
            {
                flag = NumberConstant.One,
                objectData = _serviceReview.GetReviewWithHisNavigations(id),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
        }

        [HttpPost("saveReviewForm"), Authorize("ADD_REVIEW,UPDATE_ANNUALINTERVIEW")]
        public ResponseData SaveReviewForm([FromBody] ReviewFormViewModel objectSave)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            _serviceReview.AddReviewForm(objectSave, userMail);
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.flag = NumberConstant.One;
            return result;
        }

        [HttpPost("closeReview"), Authorize("ADD_REVIEW,CLOSE_REVIEW")]
        public ResponseData CloseReview([FromBody] ReviewFormViewModel reviewForm)
        {
            ResponseData result = new ResponseData();
            _serviceReview.CloseReview(reviewForm);
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.flag = NumberConstant.One;
            return result;
        }

        /// <summary>
        /// GetPastObjectiveList
        /// </summary>
        /// <param name="idReview"></param>
        /// <returns></returns>
        [HttpPost("getPastObjectiveList/{idReview}"), Authorize("LIST_REVIEW,LIST_ANNUALINTERVIEW,SHOW_REVIEW")]
        public ResponseData GetPastObjectiveList(int idReview)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceReview.GetPastObjectiveList(idReview);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = NumberConstant.Two;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpPost("getPastReviewFormationList/{idReview}"), Authorize("LIST_REVIEW,LIST_ANNUALINTERVIEW,UPDATE_ANNUALINTERVIEW")]
        public ResponseData GetPastReviewFormationList(int idReview)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceReview.GetPastReviewFormationList(idReview);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = NumberConstant.Two;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpGet, Route("canAccessReviewDetails/{id}"), Authorize("LIST_REVIEW,LIST_ANNUALINTERVIEW,UPDATE_ANNUALINTERVIEW")]
        public ResponseData HasReviewDetailsAccess(int id)
        {
            ResponseData result = new ResponseData
            {
                flag = NumberConstant.One,
                objectData = _serviceReview.CanAccessReviewDetails(id),
                customStatusCode = CustomStatusCode.Accepted
            };
            return result;
        }

        [HttpGet, Route("connectedEmployeePriveleges/{id}"), Authorize("LIST_REVIEW,LIST_ANNUALINTERVIEW,UPDATE_ANNUALINTERVIEW")]
        public ResponseData ConnectedEmployeePriveleges(int id)
        {
            ResponseData result = new ResponseData
            {
                flag = NumberConstant.One,
                objectData = _serviceReview.ConnectedEmployeePriveleges(id),
                customStatusCode = CustomStatusCode.Accepted
            };
            return result;
        }

        [HttpGet, Route("fetchReportInformation/{id}"), Authorize("LIST_REVIEW,LIST_ANNUALINTERVIEW")]
        public ReviewFormViewModel FetchReportInformation(int id)
        {
            return _serviceReview.FetchReportInformation(id);
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_ANNUALINTERVIEW,UPDATE_ANNUALINTERVIEW,ADD_INTERVIEW")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
        [HttpPost("getModelByCondition"), Authorize("SHOW_REVIEW")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }
        [HttpGet("getById/{id}"), Authorize("SHOW_REVIEW")]
        public override ResponseData GetById(int id)
        {
            return base.GetById(id);
        }
    }
}
