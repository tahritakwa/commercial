using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Reporting.Treasury;
using ViewModels.DTO.Treasury;

namespace Services.Specific.Treasury.Interfaces
{
    public interface IServiceTicket : IService<TicketViewModel, Ticket>
    {
        object ValidateBLAndGenerateTicket(int id, int idSession, string userMail, bool validateBl = true);
        DataSourceResult<ReducedTicketViewModel> GetTicketsForSettlement(FilterSearchTicketViewModel model);
        IList<TicketLineViewModel> GetTicketLines(int idTicket);
    }

}
