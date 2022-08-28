using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/note")]
    public class NoteController : BaseController
    {
        public NoteController(IServiceProvider serviceProvider, ILogger<NoteController> logger)
           : base(serviceProvider, logger)
        {
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("SHOW")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }

        [HttpPost("getDataSourcePredicate"), Authorize("SHOW")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
