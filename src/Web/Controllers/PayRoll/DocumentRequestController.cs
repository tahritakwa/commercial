using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/documentRequest")]
    public class DocumentRequestController : BaseController
    {
        private readonly IServiceDocumentRequest _serviceDocumentRequest;
        private readonly SmtpSettings _smtpSettings;
        public DocumentRequestController(IServiceProvider serviceProvider, ILogger<DocumentRequestController> logger,
            IOptions<SmtpSettings> smtpSettings,
            IServiceDocumentRequest serviceDocumentRequest)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceDocumentRequest = serviceDocumentRequest;
            _smtpSettings = smtpSettings.Value;
        }


        [HttpPost("getDocumentRequestsWithHierarchy"), Authorize("LIST_DOCUMENTREQUEST")]
        public ResponseData GetDocumentRequestsWithHierarchy([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicateFormatViewModel = null;
            DateTime? month = null;
            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            if (objectToSave.model.month != null)
            {
                month = (DateTime)objectToSave.model.month.Value;
            }
            GetUserMail();
            ResponseData result = new ResponseData()
            {
                flag = NumberConstant.One,
                objectData = _serviceDocumentRequest.GetDocumentRequestsWithHierarchy(userMail, predicateFormatViewModel, month,
                              objectToSave.model.onlyFirstLevelOfHierarchy != null && objectToSave.model.onlyFirstLevelOfHierarchy.Value),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }

        [HttpPost("prepareAndSendEmail"), Authorize("UPDATE_DOCUMENTREQUEST")]
        public void PrepareAndSendEmail([FromBody] ObjectToSaveViewModel data)
        {
            MailBrodcastConfigurationViewModel configModel = JsonConvert.DeserializeObject<MailBrodcastConfigurationViewModel>(data.model.mailConfiguration.ToString());
            DocumentRequestViewModel oldDocument = new DocumentRequestViewModel();
            // old document is the entity after doing the action : ( after deleting or updating ) 
            if (data.model.objectBeforeAction != null)
            {
                oldDocument = JsonConvert.DeserializeObject<DocumentRequestViewModel>(data.model.objectBeforeAction.ToString());
            }
            string action = data.model.action.ToString();
            GetUserMail();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            _serviceDocumentRequest.PrepareAndSendMail(configModel, userMail, action, oldDocument, _smtpSettings);
        }

        [HttpPost("validate"), Authorize("VALIDATE_DOCUMENTREQUEST")]
        public ResponseData ValidateExpenseReport([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            else
            {
                GetUserMail();
                DocumentRequestViewModel model = JsonConvert.DeserializeObject<DocumentRequestViewModel>(objectToSave.model.ToString());
                ResponseData result = new ResponseData
                {
                    objectData = _serviceDocumentRequest.ValidateDocumentRequest(model, objectToSave.EntityAxisValues, userMail),
                    customStatusCode = CustomStatusCode.SuccessValidation,
                    flag = 1
                };
                return result;
            }

        }
        /// <summary>
        /// GetDocumentsFromListId
        /// </summary>
        /// <param name="listIdDocuments"></param>
        /// <returns></returns>
        [HttpPost("getDocumentsFromListId")]
        public List<DocumentRequestViewModel> GetDocumentsFromListId([FromBody] List<int> listIdDocuments)
        {
            return _serviceDocumentRequest.GetDocumentsFromListId(listIdDocuments);
        }
        /// <summary>
        /// ValidateMassiveDocuments
        /// </summary>
        /// <param name="listOfDocuments"></param>
        /// <returns></returns>
        [HttpPost("validateMassiveDocuments"), Authorize("UPDATE_DOCUMENTREQUEST")]
        public ResponseData ValidateMassiveDocuments([FromBody] List<DocumentRequestViewModel> listOfDocuments)
        {
            GetUserMail();
            _serviceDocumentRequest.ValidateMassiveDocuments(listOfDocuments, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }
        /// <summary>
        /// deleteMassiveDocumentRequest
        /// </summary>
        /// <param name="listIdDocuments"></param>
        /// <returns></returns>
        [HttpPost("deleteMassiveDocumentRequest"), Authorize("UPDATE_DOCUMENTREQUEST")]
        public ResponseData DeleteMassiveDocumentRequest([FromBody] List<int> listIdDocuments)
        {
            GetUserMail();
            _serviceDocumentRequest.DeleteMassiveDocumentRequest(listIdDocuments, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }
        /// <summary>
        /// refuseMassiveDocumentRequest
        /// </summary>
        /// <param name="listIdDocuments"></param>
        /// <returns></returns>
        [HttpPost("refuseMassiveDocumentRequest"), Authorize("UPDATE_DOCUMENTREQUEST")]
        public ResponseData RefuseMassiveDocumentRequest([FromBody] List<int> listIdDocuments)
        {
            GetUserMail();
            _serviceDocumentRequest.RefuseMassiveDocumentRequest(listIdDocuments, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                flag = NumberConstant.One
            };
            return result;
        }

        [HttpPost("insert"), Authorize("ADD_DOCUMENTREQUEST")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
                return base.Post(files, objectSaved, objectJsonToSave);
        }

        [HttpPut("update"), Authorize("UPDATE_DOCUMENTREQUEST")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }

        [HttpPost("getDataSourcePredicate"), Authorize("UPDATE_DOCUMENTREQUEST")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
