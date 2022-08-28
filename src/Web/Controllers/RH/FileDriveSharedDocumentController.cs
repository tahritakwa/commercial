using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.RH.Interfaces;
using Settings.Exceptions;
using System;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using Web.Controllers.GenericController;
using Web.Controllers.PayRoll;

namespace Web.Controllers.RH
{
    [Route("api/fileDriveSharedDocument")]
    public class SharedDocumentController : BaseController
    {
        private readonly IServiceFileDriveSharedDocument _serviceSharedDocument;
        public SharedDocumentController(IServiceProvider serviceProvider, ILogger<TeamController> logger
            , IServiceFileDriveSharedDocument serviceSharedDocument)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceSharedDocument = serviceSharedDocument;
        }

        /// <summary>
        /// adding document which is shared to employee and send mail
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("addSharedDocumentAndSendMail"), Authorize("ADD_FILEDRIVESHAREDDOCUMENT")]
        public ResponseData SendingSharedDocument([FromBody] ObjectToSaveViewModel objectToSave)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                GetUserMail();
                FileDriveSharedDocumentViewModel sharedDocumentViewModel = null;
                if (objectToSave.model.SharedDocument != null)
                {
                    sharedDocumentViewModel = JsonConvert.DeserializeObject<FileDriveSharedDocumentViewModel>(objectToSave.model.SharedDocument.ToString());
                }

                result.listObject = new ListObject
                {
                    listData = _serviceSharedDocument.AddSharedDocumentAndSendMail(objectToSave.model.Url != null ? objectToSave.model.Url.Value : false,
                    sharedDocumentViewModel, userMail)
                };
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
            }
            return result;
        }




    }
}
