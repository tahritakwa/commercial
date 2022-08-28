using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.ErpSettings.Classes
{
    [Route("api/message")]
    public class MessageController : BaseController
    {
        private readonly AppSettings _appSettings;
        public MessageController(IOptions<AppSettings> appSettings, IServiceProvider serviceProvider, ILogger<MessageController> logger)
            : base(serviceProvider, logger)
        {
            _appSettings = appSettings.Value;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("LIST_DOCUMENTREQUEST")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
