using System.Collections.Generic;
using ViewModels.DTO.Administration;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Payment;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Treasury;

namespace ViewModels.DTO.Shared
{
    public class BankAccountViewModel : GenericViewModel
    {
        public string Rib { get; set; }
        public string Iban { get; set; }
        public string Code { get; set; }
        public string Agency { get; set; }
        public string Bic { get; set; }
        public string Locality { get; set; }
        public string DeletedToken { get; set; }
        public double InitialBalance { get; set; }
        public double CurrentBalance { get; set; }
        public int IdBank { get; set; }
        public string Entitled { get; set; }
        public string Email { get; set; }
        public string Telephone { get; set; }
        public string Fax { get; set; }
        public string Pic { get; set; }
        public int? TypeAccount { get; set; }
        public int? IdCountry { get; set; }
        public int? IdCity { get; set; }
        public string ZipCode { get; set; }
        public int IdCurrency { get; set; }
        public bool IsLinked { get; set; }
        public BankViewModel IdBankNavigation { get; set; }
        public CityViewModel IdCityNavigation { get; set; }
        public CountryViewModel IdCountryNavigation { get; set; }
        public CurrencyViewModel IdCurrencyNavigation { get; set; }
        public ICollection<DocumentViewModel> Document { get; set; }
        public ICollection<PaymentSlipViewModel> PaymentSlip { get; set; } 
        public ICollection<ProjectViewModel> Project { get; set; }
        public ICollection<ReconciliationViewModel> Reconciliation { get; set; }
        public ICollection<SettlementViewModel> Settlement { get; set; }
        public ICollection<TransferOrderViewModel> TransferOrder { get; set; }


    }
}
