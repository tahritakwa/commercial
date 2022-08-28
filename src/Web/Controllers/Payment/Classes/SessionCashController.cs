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
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Payment;
using Web.Controllers.GenericController;

namespace Web.Controllers.Payment.Classes
{
    [Route("api/sessionCash")]
    public class SessionCashController : BaseController
    {
        IServiceSessionCash _serviceSessionCash;
        public SessionCashController(IServiceSessionCash serviceSessionCash
           , IServiceProvider serviceProvider, ILogger<SessionCashController> logger) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceSessionCash = serviceSessionCash;
        }

        [HttpPost("insert"), Authorize("OPEN_SESSION_CASH")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ResponseData result = new ResponseData();

            SessionCashViewModel instanceType = JsonConvert.DeserializeObject<SessionCashViewModel>(objectSaved.model.ToString());

            var obj = _serviceSessionCash.AddModel(instanceType, objectSaved.EntityAxisValues, userMail, null, objectSaved.isFromModal);
            result.customStatusCode = CustomStatusCode.SessionCashOpenedSuccessfull;
            result.objectData = obj;
            result.flag = 1;
            return result;

        }
        [HttpPut("update"), Authorize("CLOSE_SESSION_CASH")]
        public override ResponseData Put(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {

                SessionCashViewModel instanceType = JsonConvert.DeserializeObject<SessionCashViewModel>(objectSaved.model.ToString());
                if (objectSaved.verifyUnicity != null)
                {
                    dynamic unictyData = JsonConvert.DeserializeObject(objectSaved.verifyUnicity.ToString());
                    if (GetUnicity(unictyData))
                    {
                        throw new CustomException(CustomStatusCode.CodeUnicity);
                    }
                }
                var obj = _serviceSessionCash.UpdateModel(instanceType, objectSaved.EntityAxisValues, userMail);
                result.customStatusCode = CustomStatusCode.SessionCashClosedSuccessfull;
                result.objectData = obj;
                result.flag = 1;
                return result;
            }
        }


        [HttpPost("getUserOpenedSession")]
        public ResponseData GetUserOpenedSession([FromBody] string email)
        {
            ResponseData result = new ResponseData();

            var obj = _serviceSessionCash.GetOpenedSession(email);
            result.objectData = obj;
            result.flag = 1;
            return result;

        }

        [HttpPost("getDataForClosingSession"), Authorize("CLOSE_SESSION_CASH")]
        public ResponseData GetDataForClosingSession([FromBody] string email)
        {
            ResponseData result = new ResponseData();

            var obj = _serviceSessionCash.GetDataForClosingSessionCash(email);
            result.objectData = obj;
            result.flag = 1;
            return result;

        }

        [HttpPost("getCashRegisterSessionDetails")]
        public ResponseData GetCashRegisterSessionDetails([FromBody] ObjectToSaveViewModel model)
        {
            ResponseData result = new ResponseData();
            PredicateFormatViewModel predicateModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(model.model.predicate.ToString());
            int idCashRegister = (int)model.model.idCashRegister;
            DataSourceResult<SessionCashViewModel> dataSourceResult = _serviceSessionCash.GetCashRegisterSessionDetails(predicateModel, idCashRegister);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;

        }

        [HttpPost("getSessionDetailsById")]
        public ResponseData GetSessionDetailsById([FromBody] ObjectToSaveViewModel model)
        {
            ResponseData result = new ResponseData();
            int idTicket = (int)model.model.idTicket;
            int idDocument = (int)model.model.idDocument;
            if (idTicket != 0)
            {
                result.objectData = _serviceSessionCash.GetSessionByIdTicket(idTicket);
            }
            else if (idDocument != 0)
            {
                result.objectData = _serviceSessionCash.GetSessionByIdDocument(idDocument);

            }
            result.flag = 1;
            return result;
        }
    }
}
