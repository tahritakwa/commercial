using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Reporting.Interfaces;
using System;
using System.Collections.Generic;
using ViewModels.DTO.RH;
using Web.Controllers.GenericController;

namespace Web.Controllers.Reporting
{
    [Route("api/reviewReporting")]
    [AllowAnonymous]
    public class ReviewReportingController : BaseController
    {
        private readonly IServiceReviewReporting _serviceReviewReporting;
        public ReviewReportingController(IServiceProvider serviceProvider, ILogger<RhReportingController> logger,
            IServiceReviewReporting serviceReviewReporting) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceReviewReporting = serviceReviewReporting;
        }

        [HttpGet("getReviewForReport/{idReview}")]
        public ReviewReportingInformationViewModel GetReviewForReport(int idReview)
        {
            return _serviceReviewReporting.GetReviewForReport(idReview);
        }

        // past 

        [HttpGet, Route("getPastReviewObjectiveForReport/{idReview}"), Authorize(Roles = "SHOW")]
        public ICollection<ObjectiveViewModel> GetPastReviewObjectiveForReport(int idReview)
        {
            var pastObjectives = _serviceReviewReporting.ReviewPastObjectiveForReport(idReview);
            return pastObjectives;
        }

        [HttpGet, Route("getPastReviewFormationForReport/{idReview}"), Authorize(Roles = "SHOW")]
        public ICollection<ReviewFormationViewModel> GetPastReviewFormationForReport(int idReview)
        {
            var pastFormations = _serviceReviewReporting.ReviewPastReviewFormationForReport(idReview);
            return pastFormations;
        }

        [HttpGet, Route("getPastReviewSkillsForReport/{idReview}"), Authorize(Roles = "SHOW")]
        public ICollection<ReviewSkillsViewModel> GetPastReviewSkillsForReport(int idReview)
        {
            return _serviceReviewReporting.ReviewPastReviewSkillsForReport(idReview);
        }

        // Future

        [HttpGet, Route("getFutureReviewObjectiveForReport/{idReview}"), Authorize(Roles = "SHOW")]
        public ICollection<ObjectiveViewModel> GetFutureReviewObjectiveForReport(int idReview)
        {
            var futureObjective =  _serviceReviewReporting.ReviewFutureObjectiveForReport(idReview);
            return futureObjective;
        }

        [HttpGet, Route("getFutureReviewFormationForReport/{idReview}"), Authorize(Roles = "SHOW")]
        public ICollection<ReviewFormationViewModel> GetFutureReviewFormationForReport(int idReview)
        {
            return _serviceReviewReporting.ReviewFutureReviewFormationForReport(idReview);
        }

        [HttpGet, Route("getFutureReviewSkillsForReport/{idReview}"), Authorize(Roles = "SHOW")]
        public ICollection<ReviewSkillsViewModel> GetFutureReviewSkillsForReport(int idReview)
        {
            return _serviceReviewReporting.ReviewFutureReviewSkillsForReport(idReview);
        }
    }
}