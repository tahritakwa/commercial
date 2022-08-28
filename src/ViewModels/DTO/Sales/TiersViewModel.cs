using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using ViewModels.DTO.Administration;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Sales
{

    public class TiersViewModel : GenericViewModel
    {
        public int? IdTierCategory { get; set; }
        public int? IdLegalForme { get; set; }
        public int? IdPaymentCondition { get; set; }
        public int IdTypeTiers { get; set; }
        public int? IdCity { get; set; }
        public int? IdCountry { get; set; }
        [Required(ErrorMessage = "A Tier Name is required")]
        public string Name { get; set; }
        public string Logo { get; set; }
        public string Adress { get; set; }
        public string Region { get; set; }
        public double? AuthorizedSettlement { get; set; }
        [Key]
        [Required(ErrorMessage = "A Tier Code is required")]
        public string CodeTiers { get; set; }
        public int? Status { get; set; }
        public string Rib { get; set; }
        public double? Discount { get; set; }
        public string CIN { get; set; }
        public string MatriculeFiscale { get; set; }
        public int? IdPaymentMethod { get; set; }
        public int? IdAccountingAccountTiers { get; set; }
        public string CounterPartyAccount { get; set; }
        public string CommercialRegister { get; set; }
        public string Cp { get; set; }
        [Required(ErrorMessage = "A Tier TaxeGroup is required")]
        public int? IdTaxeGroupTiers { get; set; }
        public virtual TaxeGroupTiersViewModel IdTaxeGroupTiersNavigation { get; set; }
        public ICollection<ContactViewModel> Contact { get; set; }
        public DateTime? CreationDate { get; set; }

        public string UnicityMessage { get; set; }
        public double? AuthorizedAmountOrder { get; set; }
        public double? AuthorizedAmountDelivery { get; set; }
        public double? AuthorizedAmountInvoice { get; set; }
        public double? OrderAmount { get; set; }
        public double? DeliveryAmount { get; set; }
        public double? InvoiceAmount { get; set; }

        [Required(ErrorMessage = "A Tier Currency is required")]
        public int? IdCurrency { get; set; }
        public int? DeleveryDelay { get; set; }
        public int? PaymentDelay { get; set; }
        public bool? IsCash { get; set; }
        public double? ProvisionalAuthorizedAmountDelivery { get; set; }
        public int? IdPhone { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public virtual PhoneViewModel IdPhoneNavigation { get; set; }
        public TierCategoryViewModel IdTierCategoryNavigation { get; set; }


        public ICollection<DocumentViewModel> Document { get; set; }
        public CurrencyViewModel IdCurrencyNavigation { get; set; }
        public TypeTiersViewModel IdTypeTiersNavigation { get; set; }
        public ICollection<DocumentExpenseLineViewModel> DocumentExpenseLine { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
        public string Linkedin { get; set; }
        public string Facebook { get; set; }
        public string Twitter { get; set; }
        public string Description { get; set; }
        public string MapLocalisation { get; set; }
        public string UrlPicture { get; set; }
        public string ActivitySector { get; set; }
        public string LeadSource { get; set; }
        public bool IsAffected { get; set; }
        public int? TiersClassification { get; set; }
        public bool? WasLead { get; set; }
        public bool? IsSynchronizedBtoB { get; set; }

        public ICollection<AddressViewModel> Address { get; set; }
        public ICollection<DateToRememberViewModel> DateToRemember { get; set; }

        public virtual ICollection<FinancialCommitmentViewModel> FinancialCommitment { get; set; }
        public virtual ICollection<TiersPricesViewModel> TiersPrices { get; set; }

        public int? IdEcommerceCustomer { get; set; }
        public NumberFormatOptionsViewModel FormatOption { get; set; }
        public virtual FileInfoViewModel PictureFileInfo { get; set; }
        public int? IdSettlementMode { get; set; }
        public int? IdDeliveryType { get; set; }
        public int? IdSalesPrice { get; set; }
        public virtual SettlementModeViewModel IdSettlementModeNavigation { get; set; }
        public  ICollection<VehicleViewModel> Vehicle { get; set; }

    }
}
