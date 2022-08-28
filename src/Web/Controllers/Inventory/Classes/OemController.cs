using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Inventory.Interfaces;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Inventory.TecDoc;
using Web.Controllers.GenericController;
using Web.Controllers.Inventory.Interfaces;

namespace Web.Controllers.Inventory.Classes
{
    [Route("api/oem")]
    public class OemController : BaseController, IOemController
    {
        private readonly IServiceOem _serviceOem;
        public OemController(IServiceProvider serviceProvider,
            IServiceOem serviceOem, ILogger<OemController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceOem = serviceOem;
        }

        [HttpPost("getOemList"), Authorize("LIST")]
        public ResponseData GetListForOemSubscription([FromBody] TeckDockWithWarehouseFilterViewModel TecDocItem)
        {
            ResponseData result = null;
            try
            {
                result = new ResponseData
                {
                    objectData =_serviceOem.getOemSubs(TecDocItem),
                    flag = 1,
                    customStatusCode = CustomStatusCode.GetPredicateSuccessfull
                };
                return result;
            }
            catch
            {
                result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.TecDocConnectionError
                };
                return result;
            }
        }
    }
}
