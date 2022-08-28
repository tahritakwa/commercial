using Infrastruture.Utility;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Persistence;
using Services.Specific.Payment.Interfaces;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Reporting.Generic;
using Web.Controllers.GenericController;

namespace Web.Controllers.Payment.Classes
{
    [Route("api/paymentSlip")]
    public class PaymentSlipController : BaseController
    {
        readonly IServicePaymentSlip _servicePaymentSlip;
        readonly IServiceSettlement _serviceSettlement;
        public PaymentSlipController(
            IServiceProvider serviceProvider,
            ILogger<PaymentSlipController> logger,
            IServicePaymentSlip servicePaymentSlip,
            IServiceSettlement serviceSettlement)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _servicePaymentSlip = servicePaymentSlip;
            _serviceSettlement = serviceSettlement;
        }


        [HttpPost("addPaymentSlip"), Authorize("ADD_TREASURY_BANK_SLIP")]
        public ResponseData AddPaymentSlip([FromBody] ObjectToSaveViewModel objectToSave)
        {
            GetUserMail();
            PaymentSlipViewModel model = JsonConvert.DeserializeObject<PaymentSlipViewModel>((objectToSave.model.paymentSlip).ToString());
            List<int> settlementIds = JsonConvert.DeserializeObject<List<int>>((objectToSave.model.settlementIds).ToString());
            _servicePaymentSlip.AddPaymentSlip(model, settlementIds, userMail);
            ResponseData result = new ResponseData()
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }

        [HttpPost("getPaymentSlip"), Authorize("LIST,LIST_TREASURY_BANK_SLIP")]
        public ResponseData GetPaymentSlip([FromBody] ObjectToSaveViewModel objectToSave)
        {

            PredicateFormatViewModel predicate = JsonConvert.DeserializeObject<PredicateFormatViewModel>(objectToSave.model.predicate.ToString());
            DateTime? startDate = objectToSave.model.StartDate != null ? Convert.ToDateTime(objectToSave.model.StartDate) : null;
            DateTime? endDate = objectToSave.model.EndDate != null ? Convert.ToDateTime(objectToSave.model.EndDate) : null;
            ResponseData result = new ResponseData()
            {
                objectData = _servicePaymentSlip.GetPaymentSlip(startDate, endDate, predicate),
                flag = 1,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }

        [HttpPost("validatePaymentSlip")]
        public ResponseData ValidatePaymentSlip([FromBody] ObjectToSaveViewModel objectToSave)
        {
            GetUserMail();
            bool hasRole = true;
            PaymentSlipViewModel model = JsonConvert.DeserializeObject<PaymentSlipViewModel>((objectToSave.model.paymentSlip).ToString());
            if (model.State == (int)PaymentSlipStatusEnumerator.Valid)
            {
                hasRole = RoleHelper.HasPermission("VALIDATION_TREASURY_BANK_SLIP");
            }
            if (model.State == (int)PaymentSlipStatusEnumerator.PaymentSlipIssued)
            {
                hasRole = RoleHelper.HasPermission("TO_ISSUED_TREASURY_BANK_SLIP");
            }
            if (model.State == (int)PaymentSlipStatusEnumerator.PaymentSlipBankFeedBack)
            {
                hasRole = RoleHelper.HasPermission("IN_BANK_TREASURY_BANK_SLIP");
            }
            if (model.State == (int)PaymentSlipStatusEnumerator.Provisional)
            {
                hasRole = RoleHelper.HasPermission("UPDATE_TREASURY_BANK_SLIP");
            }
            if (!hasRole)
            {
                {
                    return new ResponseData
                    {
                        customStatusCode = CustomStatusCode.Unauthorized
                    };
                }
            }
            List<int> settlementIds = JsonConvert.DeserializeObject<List<int>>((objectToSave.model.settlementIds).ToString());
            _servicePaymentSlip.ValidatePaymentSlip(model, settlementIds, userMail);
            ResponseData result = new ResponseData()
            {
                flag = 1,
                customStatusCode = CustomStatusCode.GetPredicateSuccessfull
            };
            return result;
        }

        [HttpPost("getUnicity"), Authorize("ADD_TREASURY_BANK_SLIP,UPDATE_TREASURY_BANK_SLIP,LIST_TREASURY_BANK_SLIP")]
        public override bool GetUnicity([FromBody] object objectToCheck)
        {
            return base.GetUnicity(objectToCheck);
        }

        [HttpPost("getModelByCondition"), Authorize("UPDATE_TREASURY_BANK_SLIP,LIST_TREASURY_BANK_SLIP")]
        public override ResponseData GetModelByCondition([FromBody] PredicateFormatViewModel predicate)
        {
            return base.GetModelByCondition(predicate);
        }

        [HttpPost("downloadJasperDocumentReport"), Authorize("PRINT_TREASURY_BANK_SLIP")]
        public override async Task<ResponseData> DownloadJasperDocumentReport([FromBody] DownloadReportDataViewModel data)
        {
            return await base.DownloadJasperDocumentReport(data);
        }
        [HttpDelete("delete/{id}"), Authorize("DELETE_TREASURY_BANK_SLIP")]
        public override ResponseData Delete(int id)
        {
            return base.Delete(id);
        }

        }
}
