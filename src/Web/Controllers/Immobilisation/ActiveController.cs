using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
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
    [Route("api/active")]
    public class ActiveController : BaseController
    {
        private readonly IServiceActive _serviceActive;
        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        /// <param name="serviceRecruitment"></param>
        public ActiveController(IServiceProvider serviceProvider,
            ILogger<ActiveController> logger,
            IServiceActive serviceActive)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceActive = serviceActive;
        }

        [HttpGet("getImmobilizations")]
        public object GetImmobilizations()
        {
            object listOfData;
            listOfData = _serviceActive.GetAllModels();
            return listOfData;
        }

        [HttpPost, Route("getActifsByFiltres")]
        public ResponseData getActifsByFiltres([FromBody] ObjectToSaveViewModel objectSaved)
        {
            PredicateFormatViewModel predicateFormatViewModel = null;
            if (objectSaved.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectSaved.model.predicate.ToString());
            }
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceActive.GetActifsByFiltres(predicateFormatViewModel),
                customStatusCode = CustomStatusCode.GetSuccessfull
            };
            return result;
        }
        [HttpGet("getDataDropdown"), Authorize("ADD_ACTIVE,UPDATE_ACTIVE,LIST_ASSIGNMENT_ACTIVE,ADD_ASSIGNMENT_ACTIVE")]

        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }

        [HttpPost("getDataSourcePredicate"), Authorize("GENERATE_DOCUMENT_FROM_ACTIVES,AMORTIZATION_OF_IMMOBILIZATIONS,LIST_ACTIVE")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("insert"), Authorize("AMORTIZATION_OF_IMMOBILIZATIONS,ADD_ACTIVE")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }

        [HttpPost("getModelByCondition"), Authorize("ADD_ACTIVE, UPDATE_ACTIVE, AMORTIZATION_OF_IMMOBILIZATIONS")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            ResponseData test = new ResponseData
            {
                objectData = _service.GetModelWithRelations(predicate),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };

            return test;
        }

    }

}
