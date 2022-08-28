using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/phone")]
    public class PhoneController :  BaseController
    {
        private readonly AppSettings _appSettings;
        public PhoneController(IOptions<AppSettings> appSettings, IServiceProvider serviceProvider, ILogger<PhoneController> logger) : base(serviceProvider, logger)
        {
            _appSettings = appSettings.Value;
        }
    }
}
