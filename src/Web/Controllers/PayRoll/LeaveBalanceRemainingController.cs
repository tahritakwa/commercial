using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using System;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.PayRoll;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/leaveBalanceRemaining")]
    public class LeaveBalanceRemainingController : BaseController
    {
        private readonly IServiceLeaveBalanceRemaining _serviceLeaveBalanceRemaining;

        private readonly SmtpSettings _smtpSettings;
        public LeaveBalanceRemainingController(IServiceProvider serviceProvider,
           ILogger<LeaveBalanceRemainingController> logger,
           IOptions<SmtpSettings> smtpSettings,
           IServiceLeaveBalanceRemaining serviceLeaveBalanceRemaining)
           : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceLeaveBalanceRemaining = serviceLeaveBalanceRemaining;
            _smtpSettings = smtpSettings.Value;
        }
        [HttpPost("getDataLeaveBalanceRemainingList"), Authorize("LIST_LEAVEREMAININGBALANCE")]
        public ResponseData GetDataLeaveBalanceRemainingList([FromBody] PredicateFormatViewModel model)
        {
            GetUserMail();
            ResponseData result = new ResponseData();
            var dataSourceResult = _serviceLeaveBalanceRemaining.GetLeaveBalanceRemainingList(model, userMail);
            result.listObject = new ListObject
            {
                listData = dataSourceResult.data,
                total = dataSourceResult.total
            };
            result.flag = 2;
            result.customStatusCode = CustomStatusCode.GetPredicateSuccessfull;
            return result;
        }
        [HttpPost("getleaveBalanceRemaining"), Authorize("LIST_LEAVEREMAININGBALANCE")]
        public ResponseData GetDataLeaveBalanceRemaining([FromBody] LeaveBalanceRemainingFilter leaveBalanceRemainingFilter)
        {
            DataSourceResult<LeaveBalanceRemainingLine> leaveBalance = _serviceLeaveBalanceRemaining.GetLeaveBalanceRemaining(leaveBalanceRemainingFilter);
            ResponseData result = new ResponseData
            {
                flag = 1,
                objectData = leaveBalance,
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }
        [HttpPost("getDataLeaveBalanceRemainingByIdEmployee/{IdEmployee}"), Authorize("LIST_LEAVEREMAININGBALANCE")]
        public ResponseData GetDataLeaveBalanceRemainingByIdEmployee(int IdEmployee)
        {
            ResponseData result = new ResponseData
            {
                objectData = _serviceLeaveBalanceRemaining.GetDataLeaveBalanceRemainingByIdEmployee(IdEmployee),
                flag = 1

            };
            return result;
        }

        [HttpPost("calculateLeaveBalanceRemaining"), Authorize("CALCULATE_LEAVE_REMAINING_BALANCE")]
        public ResponseData CalculateLeaveBalance([FromBody] LeaveBalanceRemainingFilter leaveBalanceRemainingFilter)
        {
            _serviceLeaveBalanceRemaining.CalculateAllLeaveBalance(leaveBalanceRemainingFilter: leaveBalanceRemainingFilter);
            ResponseData result = new ResponseData
            {
                flag = NumberConstant.One
            };
            return result;
        }
    }
}
