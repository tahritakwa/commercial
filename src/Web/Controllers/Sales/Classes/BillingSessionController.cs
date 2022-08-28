using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.Sales.Interfaces;
using System;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using Web.Controllers.GenericController;

namespace Web.Controllers.Sales.Classes
{
    [Route("api/billingSession")]
    public class BillingSessionController : BaseController
    {
        private readonly IServiceBillingSession _serviceBillingSession;
        public BillingSessionController(IServiceBillingSession serviceBillingSession, IServiceProvider serviceProvider,
            ILogger<BillingSessionController> logger)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceBillingSession = serviceBillingSession;
        }

        [HttpGet("getTimeSheetDetailsByEmployee/{idSession}")]
        public ResponseData GetTimeSheetDetailsByEmployee(int idSession)
        {
            ResponseData responseData = new ResponseData();
            if (idSession > NumberConstant.Zero)
            {
                responseData.flag = NumberConstant.One;
                responseData.objectData = _serviceBillingSession.GetTimeSheetDetailsByEmployee(idSession);
                responseData.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            };
            return responseData;
        }

        [HttpGet("getBillingSessionDetails/{id}"), Authorize(Roles = "SHOW")]
        public ResponseData GetBillingSessionDetails(int id)
        {
            ResponseData result = new ResponseData();
            if (id > NumberConstant.Zero)
            {
                result.flag = NumberConstant.One;
                result.objectData = _serviceBillingSession.GetBillingSessionDetails(id);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;
            }
            return result;
        }
        [HttpPost("getDocumentsGenerated")]
        [AllowAnonymous]
        public ResponseData GetDocumentsGenerated([FromBody] ObjectToSaveViewModel objectToSave)
        {
            ResponseData result = new ResponseData();
            PredicateFormatViewModel predicateFormatViewModel = new PredicateFormatViewModel();
            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            if (predicateFormatViewModel.Filter != null)
            {
                result.flag = NumberConstant.One;
                result.objectData = _serviceBillingSession.GetDocumentsGenerated(predicateFormatViewModel);
                result.customStatusCode = CustomStatusCode.GetByIdSuccessfull;                
            }
            return result;
        }

        [HttpPost, Route("getEmployeesAffectedToBillableProject"), Authorize("LIST_EMPLOYEEPROJECT")]
        public ResponseData GetEmployeesAffectedToProject([FromBody] ObjectToSaveViewModel objectToSave)
        {
            PredicateFormatViewModel predicateFormatViewModel = new PredicateFormatViewModel();
            if (objectToSave.model.predicate != null)
            {
                predicateFormatViewModel = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            }
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = _serviceBillingSession.GetEmployeesAffectedToBillableProject(objectToSave.model.month != null ? objectToSave.model.month.Value : null, predicateFormatViewModel),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
    }
}
