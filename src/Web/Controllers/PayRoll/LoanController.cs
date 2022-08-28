using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using System;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/loan")]
    public class LoanController : BaseController
    {
        private readonly IServiceLoan _serviceLoan;
        private readonly SmtpSettings _smtpSettings;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="serviceProvider"></param>
        /// <param name="logger"></param>
        /// <param name="serviceLoan"></param>
        public LoanController(IServiceProvider serviceProvider,
            ILogger<LoanController> logger,
            IOptions<SmtpSettings> smtpSettings,
            IServiceLoan serviceLoan)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceLoan = serviceLoan;
            _smtpSettings = smtpSettings.Value;

        }
        /// <summary>
        /// validate or cancel the loan request
        /// </summary>
        /// <param name="objectToSave"></param>
        /// <returns></returns>
        [HttpPost("validate"), Authorize("VALIDATE_LOAN,REFUSE_LOAN")]
        public ResponseData ValidateOrCancelRequest([FromBody] ObjectToSaveViewModel objectToSave)
        {
            if (objectToSave == null)
            {
                throw new ArgumentNullException(nameof(objectToSave));
            }
            else
            {
                LoanViewModel loantViewModel = JsonConvert.DeserializeObject<LoanViewModel>(objectToSave.model.ToString());
                GetUserMail();
                _serviceLoan.ValidateRequest(loantViewModel, objectToSave.EntityAxisValues, userMail, _smtpSettings);

                ResponseData result = new ResponseData
                {
                    customStatusCode = CustomStatusCode.SuccessValidation,
                    flag = NumberConstant.One
                };
                return result;
            }
        }

        /// <summary>
        /// Get net to pay
        /// </summary>
        /// <param name="loan"></param>
        /// <returns></returns>
        [HttpPost("getNetToPay"), Authorize("ADD_LOAN,SHOW_LOAN")]
        public double getNetToPay([FromBody] LoanViewModel loan)
        {
            return _serviceLoan.GetNetToPay(loan);
        }
        [HttpPost("getDataSourcePredicate"), Authorize("LIST_LOAN")]
        public override ResponseData GetDataSourcePredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataSourcePredicate(model);
        }
    }
}
