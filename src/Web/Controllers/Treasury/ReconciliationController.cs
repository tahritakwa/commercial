using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.Treasury.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Treasury;
using ViewModels.DTO.Utils;
using Web.Controllers.GenericController;

namespace Web.Controllers.Treasury
{
    [Route("api/reconciliation")]
    public class ReconciliationController : BaseController
    {
        private readonly IServiceReconciliation _serviceReconciliation;

        public ReconciliationController(
            IServiceProvider serviceProvider,
            ILogger<BankController> logger,
            IServiceReconciliation serviceReconciliation)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceReconciliation = serviceReconciliation;
        }



        /// <summary>
        /// Add reconciliation and update the settlements
        /// </summary>
        /// <param name="reconciliation"></param>
        /// <returns></returns>
        [HttpPost("cashSettlements"), Authorize("VALIDATION_TREASURY_BANK_ACCOUNT")]
        public ResponseData CashSettlements([FromBody] ObjectToSaveViewModel objectToSave)
        {
            GetUserMail();
            ReconciliationViewModel model = JsonConvert.DeserializeObject<ReconciliationViewModel>((objectToSave.model.reconciliation).ToString());
            List<int> settlementIds = JsonConvert.DeserializeObject<List<int> >((objectToSave.model.settlementIds).ToString());
            _serviceReconciliation.CashSettlements(model, settlementIds, userMail);
            ResponseData result = new ResponseData
            {
                customStatusCode = CustomStatusCode.UpdateSuccessfull,
                objectData = new CreatedDataViewModel { EntityName = "RECONCILIATION" },         
                flag = 1
            };
            return result;
        }

    }
}
