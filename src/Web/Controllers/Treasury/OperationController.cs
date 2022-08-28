using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Services.Specific.Treasury.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Treasury;
using Web.Controllers.GenericController;

namespace Web.Controllers.Treasury
{
    [Route("api/operationCash")]
    public class OperationController : BaseController
    {
        private readonly IServiceOperationCash _serviceOperation;
        public OperationController(IServiceProvider serviceProvider, ILogger<OperationController> logger,
            IServiceOperationCash serviceOperation) : base(serviceProvider, logger)
        {
            _serviceOperation = serviceOperation;
        }

        [HttpPost("getOperationsCash")]
        public ResponseData GetOperationsCash([FromBody] ObjectToSaveViewModel objectToSave)
        {
            ResponseData result = new ResponseData();

            FilterSearchOperationViewModel model = JsonConvert.DeserializeObject<FilterSearchOperationViewModel>(objectToSave.model.ToString());
            var dataSourceResult = _serviceOperation.GetOperationsCash(model);

            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total,
                sum = dataSourceResult.sum
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;

            return result;
        }
    }
}
