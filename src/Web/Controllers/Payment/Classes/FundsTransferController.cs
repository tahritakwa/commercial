using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Payment.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Payment;
using Web.Controllers.GenericController;

namespace Web.Controllers.Payment.Classes
{
    [Route("api/fundsTransfer")]
    public class FundsTransferController : BaseController
    {
        IServiceFundsTransfer _serviceFundsTransfer;
        public FundsTransferController(IServiceFundsTransfer serviceFundsTransfer, IServiceProvider serviceProvider,
            ILogger<FundsTransferController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceFundsTransfer = serviceFundsTransfer;
        }

        [HttpPost("getSourceCashsDropdown")]
        public ResponseData GetSourceCashsDropdown([FromBody] int transferType)
        {
            ResponseData result = new ResponseData();

            DataSourceResult<CashRegisterViewModel> dataSourceResult = _serviceFundsTransfer.GetSourceCashsByTransferType(transferType);

            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            return result;
        }

        [HttpPost("getDestinationCashsDropdown")]
        public ResponseData GetDestinationCashsDropdown([FromBody] int transferType)
        {
            ResponseData result = new ResponseData();

            DataSourceResult<CashRegisterViewModel> dataSourceResult = _serviceFundsTransfer.GetDestinationCashsByTransferType(transferType);

            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            return result;
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_FUNDS_TRANSFER")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("insert"), Authorize("ADD_FUNDS_TRANSFER")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
           
                return base.Post(files,objectSaved,objectJsonToSave);
         
        }

        [HttpPut("update"), Authorize("UPDATE_FUNDS_TRANSFER")]
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
        [HttpDelete("delete/{id}"), Authorize("DELETE_FUNDS_TRANSFER")]
        public override ResponseData Delete(int id)
        {
            
            return base.Delete(id);
        }
    }
}
