using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;
using ViewModels.DTO.Treasury;

namespace ViewModels.DTO.Payment
{
    public class SessionCashViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public int IdCashRegister { get; set; }
        public DateTime OpeningDate { get; set; }
        public DateTime? ClosingDate { get; set; }
        public string LastCounter { get; set; }
        public int IdSeller { get; set; }
        public int State { get; set; }
        public double OpeningAmount { get; set; }
        public double ClosingAmount { get; set; }
        public double ClosingCashAmount { get; set; }
        public double CalculatedTotalAmount { get; set; }
        public int IdResponsible { get; set; }
        public CashRegisterViewModel IdCashRegisterNavigation { get; set; }
        public UserViewModel IdSellerNavigation { get; set; }
        public UserViewModel IdResponsibleNavigation { get; set; }
        public ICollection<TicketViewModel> Ticket { get; set; }
        public ICollection<SettlementViewModel> Settlement { get; set; }
        public ICollection<OperationCashViewModel> OperationCash { get; set; }
        public ICollection<DocumentViewModel> Document { get; set; }

    }
}
