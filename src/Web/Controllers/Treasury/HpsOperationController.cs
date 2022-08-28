using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.Treasury.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ViewModels.DTO.Treasury;

namespace Web.Controllers.Treasury
{
    [Route("api/[controller]")]
    [ApiController]
    public class HpsOperationController : ControllerBase
    {
        private readonly ILogger<HpsOperationController> _logger;
        private readonly IServiceOperationCash _serviceOperation;
        public HpsOperationController(ILogger<HpsOperationController> logger, IServiceOperationCash serviceOperation)
        {
            _logger = logger;
            _serviceOperation = serviceOperation;
        }

        [HttpPost, Authorize("ADD_HPS_OPERATION")]
        public void Post([FromBody] object operation)
        {

            HpsOperationViewModel model = JsonConvert.DeserializeObject<HpsOperationViewModel>(operation.ToString());
            _serviceOperation.AddHpsOperation(model);

        }
    }
}
