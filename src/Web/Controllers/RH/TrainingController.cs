using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.RH.Interfaces;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/training")]
    public class TrainingController : BaseController
    {
        private readonly IServiceTraining _serviceTraining;
        public TrainingController(IServiceProvider serviceProvider, ILogger<TrainingController> logger,
            IServiceTraining serviceTraining)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceTraining = serviceTraining;
        }




        /// <summary>
        /// get list of training 
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost, Route("getCatalog"), Authorize("LIST_TRAINING")]
        public ResponseData GetCatalog([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceTraining.GetCatalog(model);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }
        [HttpPost("getDataSourcePredicate"), Authorize("SHOW_REVIEW")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpGet("getById/{id}"), Authorize("ADD_TRAININGSESSION,UPDATE_TRAININGSESSION,ADD_TRAININGREQUEST,UPDATE_TRAININGREQUEST")]
        public override ResponseData GetById(int id)
        {
            return base.GetById(id);
        }
        [HttpGet("getDataDropdown"), Authorize("ADD_TRAININGREQUEST,UPDATE_TRAININGREQUEST,SHOW_TRAINING_REQUEST")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }

    }
}
