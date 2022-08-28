using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using Microsoft.Extensions.Logging;
using Services.Specific.Administration.Interfaces;
using Settings.Exceptions;
using System;
using System.Linq;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Administration;
using Web.Controllers.GenericController;

namespace Web.Controllers.Shared.Classes
{
    [Route("api/currencyRate")]
    public class CurrencyRateController : BaseController
    {
        private readonly IServiceCurrencyRate _currencyRateService;

        public CurrencyRateController(IServiceProvider serviceProvider, ILogger<CurrencyRateController> logger, IServiceCurrencyRate currencyRateService) : base(serviceProvider, logger)
        {
            _currencyRateService = currencyRateService;
        }
        /// <summary>
        /// Insert Currency Rate
        /// </summary>
        /// <param name="currencyRate"></param>
        /// <returns></returns>
        [HttpPost("insertCurrencyRate"), Authorize("UPDATE_CURRENCY"), Authorize("ADD_CURRENCY")]
        public virtual ResponseData InsertCurrencyRate([FromBody] CurrencyRateViewModel currencyRate)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var obj = _currencyRateService.AddCurrencyRate(currencyRate, userMail);
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.objectData = obj;
                result.flag = 1;
                return result;
            }
        }

        /// <summary>
        /// Update Currency Rate
        /// </summary>
        /// <param name="currencyRate"></param>
        /// <returns></returns>
        [HttpPut("updateCurrencyRate"), Authorize("UPDATE_CURRENCY")]
        public ResponseData UpdateCurrencyRate([FromBody] CurrencyRateViewModel currencyRate)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var updatedEntity = _currencyRateService.UpdateCurrencyRate(currencyRate, userMail);
                result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
                result.objectData = updatedEntity;
                result.flag = 1;
                return result;
            }
        }
        [HttpDelete("delete/{id}"), Authorize("DELETE_CURRENCY")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }

        [HttpPost("getExchangeRateValue"), Authorize("LIST_CURRENCY")]
        public virtual ResponseData GetExchangeRateValue([FromBody] PredicateFormatViewModel predicate)
        {
            ResponseData result = new ResponseData();
            if (!GetServiceName())
            {
                throw new CustomException(CustomStatusCode.InternalServerError);
            }
            else
            {
                var idCurrency = int.Parse(predicate.Filter.ToList().Where(x => x.Prop == "idCurrency").FirstOrDefault().Value.ToString());
                var date = (DateTime)predicate.Filter.ToList().Where(x => x.Prop == "date").FirstOrDefault().Value;
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.objectData = _currencyRateService.GetExchangeRateValue(idCurrency, date);
                return result;
            }
        }


    }
}
