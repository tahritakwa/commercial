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

namespace Web.Controllers.Shared.Classes
{
    [Route("api/bankAccount")]
    public class BankAccountController : BaseController
    {
        private readonly IServiceBankAccount _serviceBankAccount;
        public BankAccountController(IServiceProvider serviceProvider, ILogger<BaseController> logger,
            IServiceBankAccount serviceBankAccount) : base(serviceProvider, logger)
        {
            _serviceBankAccount = serviceBankAccount;
        }

        [HttpPost("addBankAccountAssociatedToCompany"), Authorize("ADD_BANK")]
        public ResponseData AddBankAccountAssociatedToCompany([FromBody] BankAccountViewModel model)
        {
            ResponseData result = new ResponseData();
            _serviceBankAccount.AddBankAccountAssociatedToCompany(model);
            result.customStatusCode = CustomStatusCode.UpdateSuccessfull;
            result.flag = 1;
            return result;
        }

        [HttpPost("getBankAccountList"), Authorize("LIST_BANK,LIST_TREASURY_BANK_ACCOUNT,LIST_BANKACCOUNT")]
        public virtual ResponseData GetBankAccountList([FromBody] PredicateFormatViewModel model)
        {
            ResponseData result = new ResponseData();

            var dataSourceResult = _serviceBankAccount.GetBankAccountList(model);

            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }

        [HttpPost("getBankAccountWithCondition"), Authorize("LIST_BANK,LIST_TREASURY_BANK_ACCOUNT")]
        public virtual ResponseData GetBankAccountWithCondition([FromBody] PredicateFormatViewModel predicate)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceBankAccount.GetBankAccountWithCondition(predicate),
                customStatusCode = CustomStatusCode.GetSuccessfull,
                flag = 1
            };

            return result;
        }

        [HttpPost("getDataDropdownWithPredicate"), Authorize("ADD_TRANSFERORDER,ADD_TREASURY_BANK_SLIP,UPDATE_TREASURY_BANK_SLIP,SHOW_TRANSFER_ORDER,SHOW_TREASURY_BANK_SLIP,ADD_SUPPLIER_SETTLEMENT," +
            "ADD_CUSTOMER_SETTLEMENT,UPDATE_SERVICES_CONTRACT,SHOW_SERVICES_CONTRACT,ADD_SERVICES_CONTRACT")]
        public override ResponseData GetDataDropdownWithPredicate([FromBody] PredicateFormatViewModel model)
        {
            return base.GetDataDropdownWithPredicate(model);
        }
        [HttpPost("getPictures"), Authorize("LIST_BANKACCOUNT,ADD_BANKACCOUNT,UPDATE_BANKACCOUNT,SHOW_BANKACCOUNT,LIST_TREASURY_BANK_ACCOUNT,DELETE_BANKACCOUNT")]
        public override ResponseData getPictures([FromBody] List<string> paths)
        {
            return base.getPictures(paths);
        }
        [HttpPost("removeBankAccount")]
        public new ResponseData Delete([FromBody] int id)
        {
            var result = base.Delete(id);
                return result;
        }

        [HttpPost("getBankAccountForRhPaie")]
        public BankAccountViewModel GetBankAccountForRhPaie()
        {
            var result = _serviceBankAccount.GetBankAccountForRhPaie();
            return result;
        }


    }
}
