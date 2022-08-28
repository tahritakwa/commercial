using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Persistence;
using Services.Specific.Immobilisation.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;

namespace Web.Controllers.Immobilisation
{
    [Route("api/category")]
    public class CategoryController : BaseController
    {
        private readonly IServiceCategory _serviceCategory;
        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        /// <param name="serviceRecruitment"></param>
        public CategoryController(IServiceProvider serviceProvider,
            ILogger<CategoryController> logger,
            IServiceCategory serviceCategory)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceCategory = serviceCategory;
        }
        [HttpGet("getDataDropdown"), Authorize("ADD_ACTIVE,UPDATE_ACTIVE,AMORTIZATION_OF_IMMOBILIZATIONS,GENERATE_DOCUMENT_FROM_ACTIVES")]

        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }

        [HttpPost("getDataSourcePredicate"), Authorize("AMORTIZATION_OF_IMMOBILIZATIONS,ADD_ACTIVE,GENERATE_DOCUMENT_FROM_ACTIVES")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("insert"), Authorize("AMORTIZATION_OF_IMMOBILIZATIONS,ADD_ACTIVE,GENERATE_DOCUMENT_FROM_ACTIVES,UPDATE_ACTIVE")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }

        [HttpPut("update"), Authorize("AMORTIZATION_OF_IMMOBILIZATIONS,ADD_ACTIVE,GENERATE_DOCUMENT_FROM_ACTIVES,UPDATE_ACTIVE")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }

        /// <summary>
        /// delete entity
        /// </summary>
        /// <param name="model"> entity</param>
        /// <returns> respons HTTP :
        /// ResponseJson.Success if The entity is deleted
        /// ResponseJson.Failed if The entity is not deleted
        /// ResponseJson.BadRequest if the params was null
        /// </returns>
        [HttpDelete("delete/{id}"), Authorize("ADD_CATEGORY, EDIT_CATEGORY, DELETE_CATEGORY,ADD_ACTIVE,UPDATE_ACTIVE")]
        public override ResponseData Delete(int id)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var obj = _service.DeleteModel(id, modelName, userMail);
                result.flag = 1;
                result.customStatusCode = CustomStatusCode.DeleteSuccessfull;
                result.objectData = obj;

            }
            return result;
        }
    }
}
