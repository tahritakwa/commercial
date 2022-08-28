using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.Payment.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Enumerators.TreasuryEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Payment;
using Web.Controllers.GenericController;

namespace Web.Controllers.Payment.Classes
{
    [Route("api/cashRegister")]
    public class CashRegisterController : BaseController
    {
        IServiceCashRegister _serviceCashRegister;
        public CashRegisterController(IServiceCashRegister serviceCashRegister
           , IServiceProvider serviceProvider, ILogger<CashRegisterController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceCashRegister = serviceCashRegister;
        }

        [HttpGet("getCashRegisterHierarchy"), Authorize("LIST_CASH_MANAGEMENT")]
        public ResponseData GetCashRegisterHierarchy()
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            DataSourceResult<CashRegisterItemViewModel> dataSourceResult = _serviceCashRegister.GetCashRegisterHierarchy(userMail);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            return result;
        }

        [HttpGet("getCashRegisterVisibility"), Authorize("LIST_CASH_MANAGEMENT")]
        public ResponseData GetCashRegisterVisibility()
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _serviceCashRegister.GetCashRegisterVisibility(userMail);
            result.customStatusCode = CustomStatusCode.GetSuccessfull;
            result.flag = 1;
            return result;
        }

        [HttpPost("insert"), Authorize("ADD_CASH_MANAGEMENT")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ResponseData result = new ResponseData();

            CashRegisterViewModel model = JsonConvert.DeserializeObject<CashRegisterViewModel>(objectSaved.model.ToString());
            var obj = _serviceCashRegister.AddModel(model, objectSaved.EntityAxisValues, userMail, "Type", objectSaved.isFromModal);
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            result.objectData = obj;
            result.flag = 1;
            return result;

        }
        [HttpPut("update"), Authorize("UPDATE_CASH_MANAGEMENT")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Put(files, objectSaved, objectJsonToSave);
        }

        [HttpDelete("delete/{id}"), Authorize("DELETE_CASH_MANAGEMENT")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }

        [HttpGet("getDataDropdown"), Authorize("ADD_CASH_MANAGEMENT,UPDATE_CASH_MANAGEMENT")]

        public override ResponseData GetDataDropdown()
        {

            return base.GetDataDropdown();
        }

        [HttpGet("getCentralCash"), Authorize("ADD_CASH_MANAGEMENT,UPDATE_CASH_MANAGEMENT")]
        public ResponseData GetCentralWarehouse()
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                result.objectData = _serviceCashRegister.GetCentralCash();
                result.customStatusCode = CustomStatusCode.GetSuccessfull;
                result.flag = 1;
            }
            return result;
        }

        [HttpPost("getModelByCondition"), Authorize("LIST_CASH_MANAGEMENT")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }

    }
}
