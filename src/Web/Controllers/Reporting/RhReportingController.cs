using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Reporting.Interfaces;
using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;
using Web.Controllers.GenericController;

namespace Web.Controllers.Reporting
{
    [Route("api/rhReporting")]
    [AllowAnonymous]
    public class RhReportingController : BaseController
    {
        private readonly IRhServiceReporting _rhServiceReporting;

        public RhReportingController(IServiceProvider serviceProvider, ILogger<RhReportingController> logger,
            IRhServiceReporting rhServiceReporting) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _rhServiceReporting = rhServiceReporting;
        }

        [HttpGet("getTimeSheetReportInformations/{idTimeSheet}/{idProject}")]
        public TimeSheetReportInformationsViewModel GetTimeSheetInformations(int idTimeSheet, int idProject)
        {
            return _rhServiceReporting.GetTimeSheetInformations(idTimeSheet, idProject);
        }

        [HttpGet("getTimeSheetLineReportInformations/{idTimeSheet}/{idProject}")]
        public IEnumerable<TimeSheetLineReportInformationsViewModel> GetTimeSheetLines(int idTimeSheet, int idProject)
        {
            return _rhServiceReporting.GetTimeSheetLines(idTimeSheet, idProject);
        }

        [HttpGet("getExitEmployeeLeaveInformations/{idExitEmployee}/{period}/{idLeaveType}")]
        public ExitEmployeeInformationsViewModel GetExitEmployeeLeaveInformations(int idExitEmployee, int period,int idLeaveType)
        {
            return _rhServiceReporting.GetExitEmployeeLeaveInformations(idExitEmployee, period, idLeaveType);
        }

        [HttpGet("getExitEmployeeLeaveLines/{idExitEmployee}/{period}/{idLeaveType}")]
        public IList<ExitEmployeeLeaveLineViewModel> GetExitEmployeeLeaveLines(int idExitEmployee,int period,int idLeaveType)
        {
            return _rhServiceReporting.GetExitEmployeeLeaveLines(idExitEmployee, period, idLeaveType);
        }
    }
}
