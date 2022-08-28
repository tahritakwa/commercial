using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Specific.Sales.Interfaces;
using System;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Sales.Document;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/DocumentLineNegotiationOptionsController")]
    public class DocumentLineNegotiationOptionsController : BaseController
    {
        private readonly IServiceDocumentLineNegotiationOptions _serviceDocumentLineNegotiationOptions;
        public DocumentLineNegotiationOptionsController(IServiceDocumentLineNegotiationOptions serviceDocumentLineNegotiationOptions, IServiceProvider serviceProvider,
            ILogger<DocumentLineNegotiationOptionsController> logger)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceDocumentLineNegotiationOptions = serviceDocumentLineNegotiationOptions;
        }

        [HttpPost("addNegotiationOption")]

        public ResponseData addNegotiationOption([FromBody] DocumentLineNegotiationOptionsViewModel documentLineNegotiationOptionsViewModel)
        {
            if (documentLineNegotiationOptionsViewModel == null)
            {
                throw new ArgumentException("");
            }
            documentLineNegotiationOptionsViewModel.IdUserNavigation = null;
            GetUserMail();          
            ResponseData responseData = new ResponseData
            {
                flag = 1,
                customStatusCode = documentLineNegotiationOptionsViewModel.Id == NumberConstant.Zero ? CustomStatusCode.AddSuccessfull : CustomStatusCode.UpdateSuccessfull,
                objectData = _serviceDocumentLineNegotiationOptions.addNegotiationOption(documentLineNegotiationOptionsViewModel, userMail)
        };
            return responseData;
        }

        [HttpPost("acceptOrRejectPrice")]

        public ResponseData AcceptOrRejectPrice([FromBody] DocumentLineNegotiationOptionsViewModel documentLineNegotiationOptionsViewModel)
        {
            if (documentLineNegotiationOptionsViewModel == null)
            {
                throw new ArgumentException("");
            }
            GetUserMail();
            _serviceDocumentLineNegotiationOptions.AcceptOrRejectPrice(documentLineNegotiationOptionsViewModel, userMail);
            ResponseData responseData = new ResponseData
            {
                flag = 1,
                customStatusCode = CustomStatusCode.SuccessValidation
            };
            return responseData;
        }

        [HttpPost("getListNegotiationByItem"), Authorize("HISTORY_ITEM,ADD_PROVISIONING,UPDATE_PROVISIONING")]
        public virtual ResponseData getListNegotiationByItem([FromBody] PredicateFormatViewModel model)
        {
            var dataSourceResult = _serviceDocumentLineNegotiationOptions.GetListNegotiationByItem(model);
            ResponseData result = new ResponseData
            {
                listObject = new ListObject
                {
                    listData = dataSourceResult.data,
                    total = dataSourceResult.total
                },
                flag = 2,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }
        [HttpPost("printNegotiation")]

        public ResponseData PrintNegotiation([FromBody]int idDocumentLine)
        {
            ResponseData responseData = new ResponseData
            {
                flag = 1,
                objectData= _serviceDocumentLineNegotiationOptions.PrintNegotiation(idDocumentLine)
            };
            return responseData;
        }
        [HttpPost("getDataSourcePredicate"), Authorize("ADD_NEGOTIATION")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
}
}
