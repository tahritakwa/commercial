using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Services.Reporting.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Reporting;
using Web.Controllers.GenericController;

namespace Web.Controllers.Reporting
{
    /// <summary>
    /// Telerik report API
    /// </summary>
    [Route("api/payRollReporting")]
    [AllowAnonymous]
    public class PayRollReportingController : BaseController
    {
        #region Fields
        private readonly IPayRollServiceReporting _payRollServiceReporting;
        private readonly IServiceJasperReporting _serviceJasperReporting;
        protected readonly AppSettings _appSettings;

        #endregion
        #region Constructor
        public PayRollReportingController(IOptions<AppSettings> appSettings, IServiceJasperReporting serviceJasperReporting, 
            IServiceProvider serviceProvider, ILogger<ReportingController> logger,
            IPayRollServiceReporting payRollServiceReporting)
            : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _payRollServiceReporting = payRollServiceReporting;
            if (appSettings != null)
            {
                _appSettings = appSettings.Value;
            }
            _serviceJasperReporting = serviceJasperReporting;
        }
        #endregion
        #region Methodes

        /// <summary>
        /// Get transfer order informations for the report
        /// </summary>
        /// <param name="idTransferOrder"></param>
        /// <param name="idCompany"></param>
        /// <returns></returns>
        [HttpGet("getTransferOrderReportInformations/{idTransferOrder}")]
        public TransferOrderReportInformationsViewModel GetTransferOrderReportInformations(int idTransferOrder)
        {
            return _payRollServiceReporting.GetTransferOrderInformations(idTransferOrder);
        }

        /// <summary>
        /// Get transfer order informations
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns></returns>
        [HttpGet("getSessionInformations/{idSession}")]
        public SessionReportInformationsViewModel GetSessionInformations(int idSession)
        {
            return _payRollServiceReporting.GetSessionInformations(idSession);
        }

        /// <summary>
        /// Get transfer order lines 
        /// </summary>
        /// <param name="idTransferOrder"></param>
        /// <returns></returns>
        [HttpGet("getTransferOrderDetails/{idTransferOrder}")]
        public IEnumerable<TransferOrderDetailsReportInformationsViewModel> GetTransferOrderDetails(int idTransferOrder)
        {
            return _payRollServiceReporting.GetTransferOrderDetails(idTransferOrder);
        }

        /// <summary>
        /// Get Session resume 
        /// </summary>
        /// <param name="idSession"></param>
        /// <returns></returns>
        [HttpGet("getSessionResume/{idSession}")]
        public IEnumerable<SessionResumeLineViewModel> GetSessionResume(int idSession)
        {
            return _payRollServiceReporting.GetSessionResume(idSession);
        }

        /// <summary>
        /// Get Cnss declaration lines
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        [HttpGet("getCnssDeclarationLines/{IdCnssDeclaration}")]
        public IList<CnssDeclarationLinesViewModel> GetCnssDeclarationLines(int IdCnssDeclaration)
        {
            return _payRollServiceReporting.GetCnssDeclarationLines(IdCnssDeclaration);
        }

        /// <summary>
        /// Get Cnss declaration informations
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        [HttpGet("getCnssDeclaration/{IdCnssDeclaration}")]
        public CnssDeclarationInformationsViewModel GetCnssDeclaration(int IdCnssDeclaration)
        {
            return _payRollServiceReporting.GetCnssDeclaration(IdCnssDeclaration, out CnssDeclarationViewModel cnssDeclarationViewModel);
        }

        /// <summary>
        /// Get Cnss declaration Summary
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        [HttpGet("getCnssDeclarationSummary/{IdCnssDeclaration}")]
        public CnssDeclarationSummaryViewModel GetCnssDeclarationSummary(int IdCnssDeclaration)
        {
            return _payRollServiceReporting.GetCnssDeclarationSummary(IdCnssDeclaration);
        }

        /// <summary>
        /// Api for get the payslip information
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        [HttpGet("getPayslipInformations/{idPayslip}")]
        public PayslipReportInformationsViewModel GetPayslipInformations(int idPayslip)
        {
            return _payRollServiceReporting.GetPayslipInformations(idPayslip);
        }

        /// <summary>
        /// Api for get the payslip lines
        /// </summary>
        /// <param name="IdCnssDeclaration"></param>
        /// <returns></returns>
        [HttpGet("getPayslipLines/{idPayslip}")]
        public IList<PayslipReportLinesViewModel> GetPayslipReportInformationLines(int idPayslip)
        {
            return _payRollServiceReporting.GetPayslipReportInformationLines(idPayslip);
        }

        /// <summary>
        /// Api for get the pay lines of exit employee
        /// </summary>
        /// <param name="idExitEmploye"></param>
        /// <returns></returns>
        [HttpGet("getExitEmployeePayInformations/{idExitEmployee}")]
        public IList<ReportDetailDateLineViewModel> GetExitEmployeePayInformations(int idExitEmployee)
        {
            return _payRollServiceReporting.GetExitEmployeePayInformations(idExitEmployee);
        }

        /// <summary>
        /// Api for get the informations of exit employee
        /// </summary>
        /// <param name="idExitEmploye"></param>
        /// <returns></returns>
        [HttpGet("getExitEmployeeInformations/{idExitEmployee}")]
        public ExitEmployeeInformationsViewModel GetExitEmployeeInformations(int idExitEmployee)
        {
            return _payRollServiceReporting.GetExitEmployeeInformations(idExitEmployee);
        }
        #endregion
    }
}
