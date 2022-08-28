using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Persistence.Entities;
using Services.Reporting.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Reporting.Generic;
using Web.Controllers.GenericController;

namespace Web.Controllers.PayRoll
{
    [Route("api/exitEmployeeLeaveLine")]
    public class ExitEmployeeLeaveLineController : BaseController
    {
        private readonly IServiceExitEmployeeLeaveLine _serviceExitEmployeeLeaveLine;
        private readonly IServiceJasperReporting _serviceJasperReporting;

        public ExitEmployeeLeaveLineController(IServiceProvider serviceProvider,
        ILogger<ExitEmployeeLeaveLineController> logger,
        IServiceExitEmployeeLeaveLine serviceExitEmployeeLeaveLine, IServiceJasperReporting serviceJasperReporting
       ) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceExitEmployeeLeaveLine = serviceExitEmployeeLeaveLine;
            _serviceJasperReporting = serviceJasperReporting;

        }

        /// <summary>
        /// Prepare List Of LeaveLine and calculate leave resume
        /// </summary>
        /// <param name="employeeExit"></param>
        /// <returns></returns>
        [HttpGet, Route("generateLeaveBalanceForExitEmployee/{idExitEmployee}"), Authorize("LIST_EXITEMPLOYEELEAVELINE")]
        public ResponseData GenerateLeaveBalanceForExitEmployee(int idExitEmployee)
        {
            _serviceExitEmployeeLeaveLine.GenerateLeaveBalanceForExitEmployee(idExitEmployee);
            ResponseData result = new ResponseData
            {
                flag = NumberConstant.One,
                customStatusCode = CustomStatusCode.AddSuccessfull
            };
            return result;
        }

        /// <summary>
        /// Get list of Leave for exit employee
        /// </summary>
        /// <param name="predicate"></param>
        /// <returns></returns>
        [HttpPost, Route("GetListOfLeave"), Authorize("LIST_EXITEMPLOYEELEAVELINE,ADD_EXITEMPLOYEE,UPDATE_EXITEMPLOYEE")]
        public ResponseData GetListOfLeave([FromBody] PredicateFormatViewModel model)
        {

            ResponseData result = new ResponseData
            {
                flag = NumberConstant.One,
                objectData = _serviceExitEmployeeLeaveLine.GetListOfLeave(model),
                customStatusCode = CustomStatusCode.GetByIdSuccessfull
            };
            return result;
        }


        /// <summary>
        /// Download All Leave resume
        /// </summary>
        /// <param name="idExitEmployee">id exit employee</param>
        /// <returns></returns>
        [HttpGet("downloadAllLeaveResume/{idExitEmployee}"), Authorize("LIST_EXITEMPLOYEELEAVELINE")]
        public async Task<ResponseData> DownloadAllLeaveResume(int idExitEmployee)
        {
            ResponseData responseData = new ResponseData();
            if (idExitEmployee != 0)
            {
                GetUserMail();
                DownloadReportDataViewModel reportSetting = _serviceExitEmployeeLeaveLine.GetAllLeaveResumeReportSettings(idExitEmployee, userMail, out IList<ExitEmployeeLeaveLine> exitEmployeeLeaveLines);
                responseData.objectData = await _serviceJasperReporting.MassiveDownLoad(reportSetting, userMail);
            }
            return responseData;
        }
    }
}
