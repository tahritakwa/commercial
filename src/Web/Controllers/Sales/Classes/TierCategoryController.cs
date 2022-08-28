using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
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
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/tierCategory")]
    public class TierCategoryController : BaseController
    {
        public TierCategoryController(IServiceProvider serviceProvider, ILogger<BaseController> logger, IOptions<AppSettings> appSettings = null, IOptions<PrinterSettings> printerSettings = null) : base(serviceProvider, logger, appSettings, printerSettings)
        {
        }


    }
}
