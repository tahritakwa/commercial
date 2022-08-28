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
    [Route("api/objective")]
    public class ObjectiveController : BaseController
    {
        private readonly IServiceObjective _serviceObjective;
        public ObjectiveController(IServiceProvider serviceProvider, ILogger<ObjectiveController> logger,
            IServiceObjective serviceObjective)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceObjective = serviceObjective;
        }

        /// <summary>
        /// DeleteObjectiveModel
        /// </summary>
        /// <param name="id"></param>
        /// <param name="hasRight"></param>
        /// <returns></returns>
        [HttpDelete("deleteObjectiveModel/{hasRight}/{id}"), Authorize("DELETE_OBJECTIVE")]
        public ResponseData DeleteObjectiveModel(int id, bool hasRight)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            _serviceObjective.DeleteObjectiveModelwithouTransaction(id, modelName, userMail, hasRight);
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.DeleteSuccessfull;
            return result;
        }
        [HttpPost("getDataSourcePredicate"), Authorize("SHOW_REVIEW")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
