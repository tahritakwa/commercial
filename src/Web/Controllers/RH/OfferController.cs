using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.RH.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.RH;
using Web.Controllers.GenericController;

namespace Web.Controllers.RH
{
    [Route("api/offer")]
    public class OfferController : BaseController
    {
        private readonly IServiceOffer _serviceOffer;
        public OfferController(IServiceProvider serviceProvider, ILogger<OfferController> logger,
           IServiceOffer serviceOffer)
           : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceOffer = serviceOffer;
        }


        [HttpPost, Route("generateOfferEmailByOffer/{lang}"), Authorize("UPDATE_OFFER,FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT")]
        public ResponseData GenerateOfferEmailById([FromBody] OfferViewModel offer, string lang)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _serviceOffer.GenerateOfferEmailByOffer(offer, lang, userMail);
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            result.flag = 1;
            return result;
        }

        [HttpGet, Route("getOfferWithHisNavigations/{id}"), Authorize("LIST_OFFER,FULL_RECRUITMENT")]
        public ResponseData GetOfferWithHisNavigations(int id)
        {
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceOffer.GetOfferWithHisNavigations(id),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };

            return result;
        }

        /// <summary>
        /// Methode call to accept the offer
        /// </summary>
        /// <param name="offer"></param>
        /// <returns></returns>
        [HttpPost, Route("acceptTheOffer"), Authorize("UPDATE_OFFER,FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT")]
        public ResponseData AcceptTheOffer([FromBody] OfferViewModel offer)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _serviceOffer.AcceptTheOffer(offer, userMail);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = 1;
            return result;
        }

        /// <summary>
        /// Method call to refuse the offer
        /// </summary>
        /// <param name="offer"></param>
        /// <returns></returns>
        [HttpPost, Route("refuseTheOffer"), Authorize("UPDATE_OFFER,FULL_RECRUITMENT")]
        public ResponseData AcceptOrRefuseTheOffer([FromBody] OfferViewModel offer)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _serviceOffer.RejectTheOffer(offer, userMail);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = 1;
            return result;
        }

        /// <summary>
        /// Method call to update the offer state when the email was send to the candidate
        /// </summary>
        /// <param name="offer"></param>
        /// <returns></returns>
        [HttpPost, Route("updateOfferAfterEmailSend"), Authorize("UPDATE_OFFER,FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT")]
        public ResponseData UpdateOfferAfterEmailSend([FromBody] OfferViewModel offer)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            result.objectData = _serviceOffer.UpdateOfferAfterEmailSend(offer, userMail);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = 1;
            return result;
        }

        [HttpPost("getDataSourcePredicate"), Authorize("FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }

        [HttpPost("getCompanyCurrencyPrecision"), Authorize("FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT")]
        public override int GetCompanyCurrencyPrecision([FromBody] string value)
        {
            return base.GetCompanyCurrencyPrecision(value);
        }

        [HttpPost("insert"), Authorize("FULL_RECRUITMENT,ADD_RECRUITMENT,UPDATE_RECRUITMENT")]
        public override ResponseData Post(IList<IFormFile> files, [FromBody] ObjectToSaveViewModel objectSaved, string objectJsonToSave)
        {
            return base.Post(files, objectSaved, objectJsonToSave);
        }
    }
}
