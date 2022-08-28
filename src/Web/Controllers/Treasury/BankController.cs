using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Shared;
using Web.Controllers.GenericController;

namespace Web.Controllers.Treasury
{
    [Route("api/bank")]
    public class BankController : BaseController
    {
        private readonly IServiceBank _serviceBank;

        public BankController(
            IServiceProvider serviceProvider,
            ILogger<BankController> logger,
            IServiceBank serviceBank)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceBank = serviceBank;
        }

        [HttpPut("updateBank"), Authorize("UPDATE_BANK")]
        public ResponseData UpdateBank([FromBody] ObjectToSaveViewModel objectSaved)
        {
            BankViewModel bank =
                JsonConvert.DeserializeObject<BankViewModel>(objectSaved.model.bank.ToString());
            ResponseData result = new ResponseData();
            if (bank != null)
            {
                GetUserMail();
                result.objectData = _serviceBank.updateBankWithFiles(bank, userMail);
                result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
                result.flag = 1;
            }
            return result;
        }

        [HttpPost("addBank"), Authorize("ADD_BANK")]
        public ResponseData addBankWithFiles([FromBody] ObjectToSaveViewModel objectSaved)
        {
            BankViewModel bank =
                JsonConvert.DeserializeObject<BankViewModel>(objectSaved.model.bank.ToString());
            ResponseData result = new ResponseData();
            if (bank != null)
            {
                GetUserMail();
                result.objectData = _serviceBank.addBankWithFiles(bank, userMail);
                result.customStatusCode = CustomStatusCode.AddSuccessfull;
                result.flag = 1;

            }
            return result;
        }

        [HttpGet("getDataDropdown"), Authorize("LIST_EMPLOYEE,ADD_BANKACCOUNT,UPDATE_BANKACCOUNT,SHOW_BANKACCOUNT,UPDATE_TREASURY_BANK_SLIP,SHOW_TREASURY_BANK_SLIP,ADD_TREASURY_BANK_SLIP,LIST_TREASURY_BANK_SLIP" +
            ",SHOW_EMPLOYEE,UPDATE_EMPLOYEE")]
        public override ResponseData GetDataDropdown()
        {
            return base.GetDataDropdown();
        }
        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_EMPLOYEE,UPDATE_EMPLOYEE,SHOW_EMPLOYEE,LIST_TREASURY_BANK_SLIP,LIST_TREASURY_BANK_ACCOUNT,ADD_TREASURY_BANK_SLIP,UPDATE_TREASURY_BANK_SLIP")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }

        [HttpGet("getAgeniesfromBank/{id}"), Authorize(Roles = "LIST")]
        public ResponseData GetAgeniesfromBank(int id)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceBank.getAgeniesfromBank(id),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };

            return result;
        }
        [HttpPost("getPictures"), Authorize("ADD_BANK,UPDATE_BANK,SHOW_BANK,LIST_TREASURY_BANK_ACCOUNT,LIST_BANK,LIST_BANKACCOUNT,DELETE_BANK")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }


    }
}
