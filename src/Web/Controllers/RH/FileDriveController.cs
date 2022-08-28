using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.RH.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/fileDrive")]
    public class FileDriveController : BaseController
    {
        private readonly IServiceFileDrive _serviceFileDrive;
      
        public FileDriveController(IServiceProvider serviceProvider, IServiceFileDrive serviceFileDrive, ILogger<FileDriveController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceFileDrive = serviceFileDrive;
        }

        [HttpGet("getFileDriveList"), Authorize("LIST_FILEDRIVE")]
        public ResponseData GetFileDriveList()
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.listObject = new ListObject
                {
                    listData = _serviceFileDrive.GetListOfFiles()
                };
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
            }
            return result;
        }

        [Route("uploadFileDrive"), Authorize("ADD_FILEDRIVE")]
        [HttpPost]
        public FileDriveViewModel UploadFile([FromBody] FileDriveViewModel fileDriveViewModel)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                return _serviceFileDrive.UploadfileDrive(fileDriveViewModel);
            }

        }
        [Route("moveFileDrive"), Authorize("ADD_FILEDRIVE")]
        [HttpPost]
        public void moveFileDrive([FromBody] ObjectToSaveViewModel objectSaved)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                IList<FileDriveViewModel> element = JsonConvert.DeserializeObject<IList<FileDriveViewModel>>(objectSaved.model.element.ToString());
                FileDriveViewModel moveTo = JsonConvert.DeserializeObject<FileDriveViewModel>(objectSaved.model.moveTo.ToString());
                _serviceFileDrive.MoveFileDrive(element[NumberConstant.Zero], moveTo);
            }
        }

        [Route("permanantDelete"), Authorize("ADD_FILEDRIVE")]
        [HttpPost]
        public void permanantDelete([FromBody] IList<FileDriveViewModel> element)
        {
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                _serviceFileDrive.PermanantDelete(element[NumberConstant.Zero]);
            }
        }
    }
}
