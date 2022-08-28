using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Administration.Interfaces;
using Settings.Exceptions;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using Web.Controllers.GenericController;
using Web.Controllers.Shared.Interfaces;

// For more information on enabling Web API for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace Web.Controllers.Shared.Classes
{
    [Route("api/axis")]
    public class AxisController : BaseController, IAxisController
    {
        private readonly IServiceAxis _serviceAxis;
        public AxisController(IServiceAxis serviceAxis, IServiceProvider serviceProvider, ILogger<AxisController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceAxis = serviceAxis;
        }

        /// <summary>
        /// Gets this instance.
        /// </summary>
        /// <param name="model">The model: a json format that contains the where predicate,
        /// orderBy predicate and the getWithRelations predicate</param>
        /// <returns>
        /// ResponseData format that contains a message If an error occurs
        /// or the specific data if it's a successful process
        /// </returns>
        [HttpPost("getDataOfAxesParentDropDown"), Authorize(Roles = "ADD")]
        public virtual ResponseData GetDataOfAxesParentDropDown([FromBody] PredicateFormatViewModel predicate)
        {
            ResponseData result = new ResponseData();
            var axisParent = _serviceAxis.GetEntityAxis(predicate);
            result.listObject = new ListObject
            {
                listData = axisParent,
            };
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }
        [HttpGet("get/{id?}"), AllowAnonymous]
        public ResponseData GetTreeListAxis(int? id)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.flag = 1;
                result.objectData = _service.GetTreeListAxis(id.Value);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }

        [HttpGet("getAxesHierarchy"), Authorize(Roles = "LIST")]
        public ResponseData GetAxesHierarchy()
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.flag = 1;
                result.objectData = _service.GetAxesHierarchy();
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }

        [HttpGet("getAxis/{id}"), AllowAnonymous]
        public ResponseData GetAxisByEntity(string id)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.flag = 1;
                result.objectData = _service.GetAxisByEntity(id);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }
    }
}
