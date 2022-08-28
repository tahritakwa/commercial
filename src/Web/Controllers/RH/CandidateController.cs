using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.RH.Interfaces;
using System;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.RH;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/candidate")]
    public class CandidateController : BaseController
    {
        private readonly IServiceCandidate _serviceCandidate;
        public CandidateController(IServiceProvider serviceProvider, ILogger<CandidateController> logger, IServiceCandidate serviceCandidate)
           : base(serviceProvider, logger)
        {
            _serviceCandidate = serviceCandidate;
        }

        [HttpGet("getDataDropdown"), Authorize("LIST_RECRUITMENT")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }

        /// <summary>
        /// Get candidates who haven't accepted any offer
        /// </summary>
        /// <returns></returns>
        [HttpPost("getAvailableCandidates"), Authorize("ADD_RECRUITMENT,FULL_RECRUITMENT")]
        public DataSourceResult<CandidateViewModel> GetAvailableCandidates()
        {
            return _serviceCandidate.GetAvailableCandidates();
        }

        [HttpGet("getById/{id}"), Authorize("SHOW")]
        public override ResponseData GetById(int id)
        {
            return base.GetById(id);
        }
    }
}
