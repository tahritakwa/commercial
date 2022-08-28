using Persistence.Entities;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Treasury.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.Treasury;

namespace ViewModels.Builders.Specific.Treasury.Classes
{
    public class TicketBuilder : GenericBuilder<TicketViewModel, Ticket>, ITicketBuilder
    {
        public List<ReducedTicketViewModel> BuildTicket(List<Ticket> tickets, int? IdPaymentType=0)
        {

            List<ReducedTicketViewModel> reducedTickets = new List<ReducedTicketViewModel>();
            List<TicketPayment> listOfTicketsPayement = tickets.SelectMany(x => x.TicketPayment


            .Where(y => (y.Status == null || y.Status.Value != (int)DocumentStatusEnumerator.TotallySatisfied) && ( IdPaymentType!=0 ? y.IdPaymentType== IdPaymentType:true))).ToList();
            listOfTicketsPayement.ForEach(x =>
            {   
                if (x.IdTicketNavigation.IdDeliveryFormNavigation != null &&
                x.IdTicketNavigation.IdDeliveryFormNavigation.IdTiersNavigation != null)
                {

                    x.IdTicketNavigation.IdDeliveryFormNavigation.IdTiersNavigation.Document = null;
                    x.IdTicketNavigation.IdDeliveryFormNavigation.IdTiersNavigation.IdCurrencyNavigation = null;
                }
                if (x.IdPaymentTypeNavigation != null)
                {
                    x.IdPaymentTypeNavigation.TicketPayment = null;
                }
                reducedTickets.Add(new ReducedTicketViewModel
                {
                    Id = x.IdTicketNavigation.Id,
                    Code = x.IdTicketNavigation.Code,
                    CreationDate = x.CreationDate,
                    IdPaymentTicket = x.Id,
                    CashRegisterName = x.IdTicketNavigation.IdSessionCashNavigation?.IdCashRegisterNavigation?.Name,
                    InvoiceCode = x.IdTicketNavigation.IdInvoiceNavigation?.Code,
                    DeliveryFormCode = x.IdTicketNavigation.IdDeliveryFormNavigation?.Code,
                    IdInvoice = x.IdTicketNavigation.IdInvoice,
                    InvoiceAmount = x.IdTicketNavigation.IdInvoiceNavigation?.DocumentTtcpriceWithCurrency,
                    InvoiceStatus = x.IdTicketNavigation.IdInvoiceNavigation?.IdDocumentStatus,
                    DeliveryFormStatus = x.IdTicketNavigation.IdDeliveryFormNavigation?.IdDocumentStatus,
                    IdDeliveryForm = x.IdTicketNavigation.IdDeliveryFormNavigation?.Id,
                    IdTiersNavigation = x.IdTicketNavigation.IdDeliveryFormNavigation?.IdTiersNavigation,
                    Amount = x.Amount,
                    TicketAmount = x.IdTicketNavigation.IdDeliveryFormNavigation?.DocumentTtcpriceWithCurrency,
                    IdPaymentTypeNavigation = x.IdPaymentTypeNavigation,
                    IdUsedCurrencyNavigation = new ReducedCurrencyViewModel()
                    {
                        Code= x.IdTicketNavigation.IdDeliveryFormNavigation?.IdUsedCurrencyNavigation.Code,
                        Description= x.IdTicketNavigation.IdDeliveryFormNavigation?.IdUsedCurrencyNavigation.Description,
                        Precision= (int) x.IdTicketNavigation.IdDeliveryFormNavigation?.IdUsedCurrencyNavigation.Precision,
                        Symbole= x.IdTicketNavigation.IdDeliveryFormNavigation?.IdUsedCurrencyNavigation.Symbole,
                        Id= (int) x.IdTicketNavigation.IdDeliveryFormNavigation?.IdUsedCurrencyNavigation.Id
                    }
                });
            });
            
            return reducedTickets;
        }
}
    


}
