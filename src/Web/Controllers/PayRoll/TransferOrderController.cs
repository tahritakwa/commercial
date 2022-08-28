using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/transferOrder")]
    public class TransferOrderController : BaseController
    {
        private readonly IServiceTransferOrder _serviceTransferOrder;
        public TransferOrderController(IServiceProvider serviceProvider, ILogger<TransferOrderController> logger, IServiceTransferOrder serviceTransferOrder)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceTransferOrder = serviceTransferOrder;
        }

        [HttpGet("getEmplpoyeesWithoutTransferOrder/{idTransferOrder}"), Authorize("SHOW_TRANSFER_ORDER")]
        public ResponseData GetEmployeesWithoutTransferOrder(int idTransferOrder)
        {
            ResponseData responseData = new ResponseData
            {
                flag = 1,
                objectData = _serviceTransferOrder.GetTransferOrderDetails(idTransferOrder),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return responseData;
        }

        /// <summary>
        /// Generate cnss declaration
        /// </summary>
        /// <param name="id"></param>
        /// <param name="max"></param>
        /// <returns></returns>
        [HttpPost("generateTransferOrder"), Authorize("GENERATE_TRANSFER_ORDER,REGENERATE_TRANSFER_ORDER")]
        public ResponseData GenerateCnssDeclaration([FromBody] TransferOrderViewModel model)
        {
            GetUserMail();
            ResponseData responseData = new ResponseData
            {
                flag = 1,
                objectData = _serviceTransferOrder.GenerateTransferDetails(model, userMail),
                customStatusCode = CustomStatusCode.AddSuccessfull
            };
            return responseData;
        }

        /// <summary>
        /// Close transfer order
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpGet("closeTransferOrder/{idTransferOrder}"), Authorize("CLOSE_TRANSFER_ORDER")]
        public ResponseData CloseTransferOrder(int idTransferOrder)
        {
            _serviceTransferOrder.CloseTransferOrder(idTransferOrder);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.SuccessValidation,
                flag = NumberConstant.One
            };
            return result;
        }

        [HttpPut("update"), Authorize("SHOW_TRANSFER_ORDER,UPDATE_TRANSFERORDER")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }
    }
}
