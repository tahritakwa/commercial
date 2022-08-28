using System;
using System.Collections.Generic;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class DocumentReportInformationsViewModel
    {
        //Company infos
        public string AdressCompany { get; set; }
        public string ZipCodeCompany { get; set; }
        public string TelCompany { get; set; }
        public string CityCompany { get; set; }
        public string NameCompany { get; set; }
        public string TVA { get; set; }
        public string VATNumberCompany { get; set; }
        public string WebSiteCompany { get; set; }
        public string PaysCompany { get; set; }
        public string SIRETCompany { get; set; }
        public string CommercialRegisterCompany { get; set; }
        public string EmailCompany { get; set; }
        public string CompanyLogo { get; set; }
        //Document infos
        public DateTime? DocumentDate { get; set; }
        public string DocumentCode { get; set; }
        public string DocumentTypeCode { get; set; }
        public string DocumentTypeLabel { get; set; }
        public double? DocumentTotalDiscountWithCurrency { get; set; }
        public double? DocumentHtpriceWithCurrency { get; set; }
        public double? DocumentTotalExcVatTaxesWithCurrency { get; set; }
        public double? DocumentPriceIncludeVatWithCurrency { get; set; }
        public double? DocumentTotalVatTaxesWithCurrency { get; set; }
        public double? DocumentOtherTaxesWithCurrency { get; set; }
        public double? DocumentTtcpriceWithCurrency { get; set; }
        public string DocumentSymboleCurrency { get; set; }
        public int? DocumentCurrencyPresicion { get; set; }
        public string MarketNum { get; set; }
        public string BenefitPeriod { get; set; }
        public string SettlementModeLabel { get; set; }
        public ICollection<DocumentLineViewModel> DocumentLine { get; set; }
        public CompanyViewModel company;
        //Tiers infos
        public string CodeTiers { get; set; }
        public string NameTiers { get; set; }
        public string AdressTiers { get; set; }
        public string MatriculeFiscalTiers { get; set; }
        public string ContractCode { get; set; }
        public string RegionTiers { get; set; }
        //Contact infos
        public string FirstNameContact { get; set; }
        public string LastNameContact { get; set; }
        public string FunctionContact { get; set; }
        public string TelContact { get; set; }
        public string EmailContact { get; set; }
        //bank account 
        public string IbanBankAccount { get; set; }
        public string BicBankAccount { get; set; }
        public string IdCreator { get; set; } = string.Empty;


    }
}
