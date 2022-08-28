using System;
using ViewModels.DTO.Administration;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Payment
{
    public class FundsTransferViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public DateTime TransferDate { get; set; }
        public int Type { get; set; }
        public int IdSourceCash { get; set; }
        public int IdDestinationCash { get; set; }
        public int? Status { get; set; }
        public double Amount { get; set; }
        public double AmountWithCurrency { get; set; }
        public int IdCurrency { get; set; }
        public int? IdCashier { get; set; }

        public virtual UserViewModel IdCashierNavigation { get; set; }
        public virtual CurrencyViewModel IdCurrencyNavigation { get; set; }
        public virtual CashRegisterViewModel IdDestinationCashNavigation { get; set; }
        public virtual CashRegisterViewModel IdSourceCashNavigation { get; set; }
    }
}
