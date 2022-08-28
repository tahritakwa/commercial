using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.Sales.Interfaces;
using Services.Specific.Shared.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Provisioning;
using ViewModels.DTO.Sales;
using Web.Controllers.GenericController;
using Web.Controllers.Sales.Interfaces;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/PriceRequest")]
    public class PriceRequestController : BaseController, IPriceRequestController
    {
        private readonly IServicePriceRequest _servicePriceRequest;
        private readonly IServiceUser _userService;
        private readonly SmtpSettings _smtpSettings;
        private readonly IServiceDocument _serviceDocument;
        public PriceRequestController(IServiceProvider serviceProvider,
            ILogger<BaseController> logger,
            IServicePriceRequest servicePriceRequest, IServiceUser userService, IOptions<SmtpSettings> smtpSettings, IServiceDocument serviceDocument
            ) : base(serviceProvider, logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
            _servicePriceRequest = servicePriceRequest;
            _userService = userService;
            _smtpSettings = smtpSettings.Value;
            _serviceDocument = serviceDocument;
        }

        [HttpPost("CreatePriceRquestFromProvisionning"), Authorize(Roles = "ADD")]
        public ResponseData CreatePriceRquestFromProvisionning([FromBody]IList<ObjectToOrder> Lines)
        {
            ResponseData result = new ResponseData();
            if (Lines != null)
            {
                result.objectData = _servicePriceRequest.CreatePriceRquestFromProvisionning(Lines);
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.flag = 1;
            }
            return result;

        }
        [HttpPost("sendPriceRequestMail"), AllowAnonymous]
        public ResponseData SendPriceRequestMail([FromBody] dynamic model)
        {
            ResponseData result = new ResponseData();
            GetUserMail();
            //get the user sended from generic factory service
            var user = _userService.GetModel(x => x.Email == userMail);
            result.objectData =  _servicePriceRequest.SendPriceRequestMail((int)model.idPriceRequest, model.informationType.ToString(), user, _smtpSettings, model.url.ToString());
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.SendMailSuccessfull;
            return result;
        }

        [HttpPost("updatePriceRequest")]
        public ResponseData UpdatePriceRequest([FromBody] PriceRequestViewModel model)
        {
            ResponseData result = new ResponseData();
            //find associated documents for the price request
            model.Document = _serviceDocument.FindModelsByNoTracked(x => model.IdDocuments.Any(y => y == x.Id)).ToList();

            _servicePriceRequest.UpdateModel(model, new List<EntityAxisValuesViewModel>(), null);
            result.flag = 1;
            result.customStatusCode = CustomStatusCode.AddSuccessfull;
            return result;
        }

        [HttpPost("getPurchaseBudget")]
        public ResponseData GetPurchaseBudget([FromBody] PredicateFormatViewModel predicate)
        {
            ResponseData result = new ResponseData();

            var priceRequest = _servicePriceRequest.GetModelWithRelations(predicate);
            priceRequest.Document = _serviceDocument.FindDocumentBudget(priceRequest.Id);
            result.objectData = priceRequest;
            return result;
        }

        [HttpPost("getPurchaseBudgetPriceRequest")]
        public ResponseData GetPurchaseBudget([FromBody] PurchaseBudgetPriceRequest purchaseBudgetPriceRequest)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GetPurchaseBudgetForPriceRequest(purchaseBudgetPriceRequest)
            };
            return result;
        }


        [HttpPost("generatePurchaseOrderFromPriceRequest")]
        public ResponseData GeneratePurchaseOrderFromPriceRequest([FromBody] List<DocumentLineWithSupplier> documentLineWithSupplier)
        {
            GetUserMail();
            ResponseData result = new ResponseData
            {
                objectData = _serviceDocument.GeneratePurchaseOrderFromPriceRequest(documentLineWithSupplier, userMail),
                flag = 1,
                customStatusCode = CustomStatusCode.AddSuccessfull
            };
            return result;
        }
        [HttpPost("getDataWithSpecificFilter"), Authorize("LIST_PRICEREQUEST")]
        public override ResponseData GetDataWithSpecificFilter([FromBody] List<PredicateFormatViewModel> model)
        {

            return base.GetDataWithSpecificFilter(model);
        }

    }
}
