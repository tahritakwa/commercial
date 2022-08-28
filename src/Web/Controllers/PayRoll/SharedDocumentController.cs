using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/sharedDocument")]
    public class SharedDocumentController : BaseController
    {
        private readonly IServiceSharedDocument _serviceSharedDocument;
        public SharedDocumentController(IServiceProvider serviceProvider, ILogger<TeamController> logger
            , IServiceSharedDocument serviceSharedDocument)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceSharedDocument = serviceSharedDocument;
        }


        [HttpPost("addSharedDocumentAndSendMail"), Authorize("ADD_SHAREDDOCUMENT")]
        public ResponseData GetJobList([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                GetUserMail();
                SharedDocumentViewModel sharedDocumentViewModel = null;
                if (objectToSave.model.SharedDocument != null)
                {
                    sharedDocumentViewModel = JsonConvert.DeserializeObject<SharedDocumentViewModel>(objectToSave.model.SharedDocument.ToString());
                }
                ResponseData result = new ResponseData()
                {
                    flag = 1,
                    listObject = new ListObject
                    {
                        listData = _serviceSharedDocument.AddSharedDocumentAndSendMail(objectToSave.model.Url != null ? objectToSave.model.Url.Value : false, sharedDocumentViewModel, userMail)
                    },
                    customStatusCode = CustomStatusCode.AddSuccessfull
                };
                return result;
            }
        }



        [HttpPost("getSharedDocumentList"), Authorize("LIST_SHAREDDOCUMENT")]
        public ResponseData getSharedDocumentList([FromBody] ObjectToSaveViewModel objectToSave)
        {
            GetUserMail();
            PredicateFormatViewModel predicateFormatViewModel = new PredicateFormatViewModel();
            DateTime? startDate = null;
            DateTime? endDate = null;

            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            if (objectToSave.model.startDate != null)
            {
                startDate = objectToSave.model.startDate;
            }
            if (objectToSave.model.endDate != null)
            {
                endDate = objectToSave.model.endDate;
            }
            ResponseData result = new ResponseData()
            {
                flag = 1,
                objectData = _serviceSharedDocument.GenerateSharedDocumentList(userMail, endDate, startDate, predicateFormatViewModel),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_OWNED_SHARED_DOCUMENT")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        /// <summary>
        /// Get data with predicate and specific filter
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost("getDataWithSpecificFilter"), Authorize("LIST_OWNED_SHARED_DOCUMENT")]
        public override ResponseData GetDataWithSpecificFilter([FromBody] List<PredicateFormatViewModel> model)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var dataSourceResult = _serviceSharedDocument.GetDataWithSpecificFilter(model);

                result.listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total,
                    sum = dataSourceResult.sum
                };
                result.flag = 2;
                result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            }
            return result;
        }
    }
}
