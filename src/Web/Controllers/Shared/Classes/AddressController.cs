using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Shared.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Shared;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/address")]
    public class AddressController : BaseController
    {
        private readonly IServiceAddress _serviceAddress;
        public AddressController(IServiceProvider serviceProvider, ILogger<AddressController> logger, IServiceAddress serviceAddress)
           : base(serviceProvider, logger)
        {
            _serviceAddress = serviceAddress;
        }
        [HttpPost, Route("addressBulkAdd"), Authorize("ADD_OFFICE")]
        public ResponseData AddressBulkAdd([FromBody] IList<AddressViewModel> address)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _serviceAddress.AddressBulkAdd(address, null);
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.flag = 1;
                return result;
            }
        }
        [HttpPost, Route("getOfficesAddress"), Authorize("LIST_OFFICE,UPDATE_OFFICE")]
        public ResponseData GetOfficesAddress([FromBody] IList<int> addressIdslist)
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
                    listData = _serviceAddress.GetOfficesAddress(addressIdslist)
                };
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
                result.flag = 1;
                return result;
            }
        }
        [HttpPost, Route("addressBulkUpdate"), Authorize("UPDATE_OFFICE")]
        public ResponseData AddressBulkUpdate([FromBody] IList<AddressViewModel> address)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _serviceAddress.AddressBulkUpdate(address, null);
                result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
                result.flag = 1;
                return result;
            }
        }
    }
}
