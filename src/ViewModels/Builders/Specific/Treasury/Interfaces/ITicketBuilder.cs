using Persistence.Entities;
using System.Collections.Generic;
using ViewModels.Builders.Generic.Interfaces;
using ViewModels.DTO.Treasury;

namespace ViewModels.Builders.Specific.Treasury.Interfaces
{
    public interface ITicketBuilder : IBuilder<TicketViewModel, Ticket>
    {
        List<ReducedTicketViewModel> BuildTicket(List<Ticket> tickets, int? IdPaymentType);
    }
}
