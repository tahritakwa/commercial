using System.Collections.Generic;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Reporting.Treasury;

namespace Services.Reporting.Interfaces
{
    public interface ITreasuryServiceReporting
    {
        List<SettlementWithholdingTaxViewModel> GetSettlementWithholdingTax(int IdSettlement);
        WithholdingTaxReportInfoViewModel GetSettlementInfos(int idSettlement);
        PaymentSlipReportInfoViewModel GetPaymentSlipDetails(int idPaymentSlip);
        List<CheckInfoViewModel> GetCheckInfo(int idPaymentSlip);
        List<DraftInfoViewModel> GetDraftInfo(int idPaymentSlip);
        SettlementInformationViewModel GetSettlementInformation(int idSettlement);
        List<SettlementDataViewModel> GetSettlementData(int idSettlement);
        TicketPosReportViewModel GetTicketPosReport(int idTicket);
        IList<TicketLineViewModel> GetTicketLines(int idTicket);  
        IList<TicketPaymentMethodViewModel> GetTicketPayment(int idTicket);
        SessionPaymentInfosViewModel GetSessionPaymentInfos(int idSession);
        IList<SessionPaymentTicketInfosViewModel> GetSessionPaymentTickets(int idSession);
        IList<SessionPaymentAmountDetailsViewModel> GetSessionTotalAmountByPaymentType(int idSession);

    }
}
