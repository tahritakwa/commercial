using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/documentRequestType")]
    public class DocumentRequestTypeController : BaseController
    {
        public DocumentRequestTypeController(IServiceProvider serviceProvider, ILogger<DocumentRequestTypeController> logger)
          : base(serviceProvider, logger)
        {
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("LIST_SHAREDDOCUMENT,ADD_DOCUMENTREQUEST,UPDATE_DOCUMENTREQUEST,LIST_OWNED_SHARED_DOCUMENT")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
    }
}
