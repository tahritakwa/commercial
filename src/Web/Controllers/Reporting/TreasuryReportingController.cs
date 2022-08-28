using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Services.Reporting.Interfaces;
using System;
using System.Collections.Generic;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Treasury;
using ViewModels.DTO.Treasury;
using Web.Controllers.GenericController;

namespace Web.Controllers.Reporting
{
    /// <summary>
    /// Jasper report API
    /// </summary>
    [Route("api/treasuryReporting")]
    [AllowAnonymous]
    public class TreasuryReportingController : BaseController
    {
        #region Fields
        private readonly ITreasuryServiceReporting _serviceTreasuryReporting;

        #endregion
        #region Constructor
        public TreasuryReportingController(IServiceProvider serviceProvider, ILogger<SalesPurchaseReportingController> logger,
            ITreasuryServiceReporting serviceTreasuryReporting) : base(serviceProvider, logger)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            _serviceTreasuryReporting = serviceTreasuryReporting;
        }
        #endregion
        #region Methodes
        [AllowAnonymous]
        [HttpGet("getSettlementInfos/{idSettlement}")]
        public WithholdingTaxReportInfoViewModel GetSettlementInfos(int idSettlement)
        {
            return _serviceTreasuryReporting.GetSettlementInfos(idSettlement);
        }

        [AllowAnonymous]
        [HttpGet("getSettlementWithholdingTax/{idSettlement}")]
        public IList<SettlementWithholdingTaxViewModel> GetSettlementWithholdingTax(int idSettlement)
        {
            return _serviceTreasuryReporting.GetSettlementWithholdingTax(idSettlement);
        }

        [AllowAnonymous]
        [HttpGet("getPaymentSlipDetails/{idPaymentSlip}")]
        public PaymentSlipReportInfoViewModel GetPaymentSlipDetails(int idPaymentSlip)
        {
            return _serviceTreasuryReporting.GetPaymentSlipDetails(idPaymentSlip);
        }

        [AllowAnonymous]
        [HttpGet("getCheckInfo/{idPaymentSlip}")]
        public List<CheckInfoViewModel> GetCheckInfo(int idPaymentSlip)
        {
            return _serviceTreasuryReporting.GetCheckInfo(idPaymentSlip);
        }

        [AllowAnonymous]
        [HttpGet("getDraftInfo/{idPaymentSlip}")]
        public List<DraftInfoViewModel> GetDraftInfo(int idPaymentSlip)
        {
            return _serviceTreasuryReporting.GetDraftInfo(idPaymentSlip);
        }
        [AllowAnonymous]
        [HttpGet("GetSettlementInformation/{idSettlement}")]
        public SettlementInformationViewModel GetSettlementInformation(int idSettlement)
        {
            return _serviceTreasuryReporting.GetSettlementInformation(idSettlement);
        }
        [AllowAnonymous]
        [HttpGet("GetSettlementData/{idSettlement}")]
        public List<SettlementDataViewModel> GetSettlementData(int idSettlement)
        {
            return _serviceTreasuryReporting.GetSettlementData(idSettlement);
        }

        [AllowAnonymous]
        [HttpGet("getTicketPosReport/{idTicket}")]
        public TicketPosReportViewModel GetTicketPosReport(int idTicket)
        {
            return _serviceTreasuryReporting.GetTicketPosReport(idTicket);
        }

        [HttpGet("getTicketLines/{idTicket}")]
        public IList<TicketLineViewModel> GetTicketLines(int idTicket)
        {
            return _serviceTreasuryReporting.GetTicketLines(idTicket);
        }
         
        
        [HttpGet("getTicketPayment/{idTicket}")]
        public IList<TicketPaymentMethodViewModel> GetTicketPayment(int idTicket)
        {
            return _serviceTreasuryReporting.GetTicketPayment(idTicket);
        }

        [HttpGet("getSessionPaymentInfos/{idSession}")]
        public SessionPaymentInfosViewModel GetSessionPaymentInfos(int idSession)
        {
            return _serviceTreasuryReporting.GetSessionPaymentInfos(idSession);
        }

        [HttpGet("getSessionPaymentTickets/{idSession}")]
        public IList<SessionPaymentTicketInfosViewModel> GetSessionPaymentTickets(int idSession)
        {
            return _serviceTreasuryReporting.GetSessionPaymentTickets(idSession);
        }
        [HttpGet("getSessionTotalAmountByPaymentType/{idSession}")]
        public IList<SessionPaymentAmountDetailsViewModel> GetSessionTotalAmountByPaymentType(int idSession)
        {
            return _serviceTreasuryReporting.GetSessionTotalAmountByPaymentType(idSession);
        }
        #endregion
    }
}
