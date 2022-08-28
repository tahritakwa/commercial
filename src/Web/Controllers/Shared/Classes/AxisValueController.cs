using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Primitives;
using Services.Specific.Administration.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;
using Web.Controllers.Shared.Interfaces;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/axisValue")]
    public class AxisValueController : BaseController, IAxisValueController
    {
        private readonly IServiceAxisValue _serviceAxisValue;

        public AxisValueController(IOptions<AppSettings> appSettings, IServiceProvider serviceProvider, ILogger<AxisValueController> logger, IServiceAxisValue serviceAxisValue) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceAxisValue = serviceAxisValue;

        }

        [HttpPost("getAxisValue"), AllowAnonymous]
        public ResponseData GetAxisValueByAxis([FromBody]PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            List<FilterViewModel> filters = new List<FilterViewModel>();
            foreach (FilterViewModel filter in model.Filter)
                filters.Add(filter);
            result.objectData = _serviceAxisValue.GetAxisValueByAxis(int.Parse(filters[0].Value.ToString()), filters.Count > 1 ? filters[1].Value.ToString().Split('#') : null);
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            return result;
        }
        [HttpGet("getValByEnt/{id?}"), AllowAnonymous]
        public ResponseData GetAxisValueByEntity(int? id)
        {
            ResponseData result = new ResponseData();
            IHeaderDictionary header;
            StringValues modelValue;
            string modelName = "";
            header = Request.Headers;

            if (header.TryGetValue("TModel", out modelValue))
            {
                modelName = modelValue.First();
                modelName = char.ToUpperInvariant(modelName[0]) + modelName.Substring(1);
            }
            result.flag = 1;
            result.objectData = _serviceAxisValue.GetAxisValueByEntity(id.Value, modelName);
            result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            return result;
        }


    }
}
