using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/recruitmentLanguage")]
    public class RecruitmentLanguageController : BaseController
    {
        public RecruitmentLanguageController(IServiceProvider serviceProvider, ILogger<RecruitmentLanguageController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpDelete("delete/{id}"), Authorize("ADD_RECRUITMENTREQUEST,ADD_RECRUITMENTOFFER,ADD_RECRUITMENT,UPDATE_RECRUITMENTREQUEST,UPDATE_RECRUITMENTOFFER,UPDATE_RECRUITMENT")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }

    }
}
