using Persistence.Entities;
using Services.Generic.Interfaces;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Interfaces
{
    public interface IServiceSessionCash : IService<SessionCashViewModel, SessionCash>
    {
        SessionCashViewModel GetOpenedSession(string email);
        object GetDataForClosingSessionCash(string email);
        DataSourceResult<SessionCashViewModel> GetCashRegisterSessionDetails(PredicateFormatViewModel model, int idCashRegister);
        public SessionCashViewModel GetSessionByIdTicket(int idTicket);
        public SessionCashViewModel GetSessionByIdDocument(int idDocument);

    }
}
