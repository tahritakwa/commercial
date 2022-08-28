using Microsoft.AspNetCore.Http;
using Settings.Config;
using System;
using System.Collections.Generic;
using ViewModels.DTO.Administration;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Shared
{
    public class CompanyViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string MatriculeFisc { get; set; }
        public string Name { get; set; }
        public string SharedDocumentsKey { get; set; }
        public string Description { get; set; }
        public string CommercialRegister { get; set; }
        public string TaxNumber { get; set; }
        public string Email { get; set; }
        public string WebSite { get; set; }
        public string Logo { get; set; }
       
        public string Tel1 { get; set; }
        public string Tel2 { get; set; }
        public string Fax { get; set; }
        
        public CurrencyViewModel IdCurrencyNavigation { get; set; }
        public int? IdCurrency { get; set; }
        public string Culture { get; set; }
        public string ConnectionString { get; set; }
        public string TaxIdentNumber { get; set; }
        public byte[] Picture { get; set; }
        public string Siret { get; set; }
       
        
        public double IdDaysOfWork { get; set; }
        public bool? WithholdingTax { get; set; }
        public double? FiscalStamp { get; set; }
        public string Nic { get; set; }
        public int? IdNaf { get; set; }
        public double? Capital { get; set; }
        public string PaymentOffset { get; set; }
        public int? IdAtrate { get; set; }
        public double? HeuRef { get; set; }
        public string RegularisationMode { get; set; }
        public IList<IFormFile> Files { get; set; }
        public string AttachmentUrl { get; set; }
        public ICollection<FileInfoViewModel> FilesInfos { get; set; }
        public FileInfoViewModel PictureFileInfo { get; set; }
        public byte[] DataLogoCompany { get; set; }
        public string VatNumber { get; set; }
        public ZipCodeViewModel IdZipCodeNavigation { get; set; }
        public DbSettings DbSettings { get; set; }
        public string CnssAffiliation { get; set; }
        public int? IdAccountingAccount { get; set; }
        public bool TimeSheetPerHalfDay { get; set; }
        public bool PayDependOnTimesheet { get; set; }
        public string Category { get; set; }
        public string SecondaryEstablishment { get; set; }
        public bool? AmputationPerHour { get; set; }
        public double? TimeInterval { get; set; }
        public double? DaysOfWork { get; set; }
        public string ActivitySector { get; set; }
        public bool? AllowEditionItemDesignation { get; set; }
        public int ActivityArea { get; set; }
        public bool AutomaticCandidateMailSending { get; set; }
        public int? IdDefaultTax { get; set; }
        public bool? AllowRelationSupplierItems { get; set; }
        public bool? NoteIsRequired { get; set; }
        public virtual TaxeViewModel IdDefaultTaxNavigation { get; set; }
        public IList<DayOfWeek> DaysOfWeekWorked  { get; set; }
        public virtual CityViewModel IdCityNavigation { get; set; }       
        public virtual CountryViewModel IdCountryNavigation { get; set; } 
        public PurchaseSettingsViewModel PurchaseSettings { get; set; }   
        public SaleSettingsViewModel SaleSettings { get; set; }
        public ICollection<Shared.ContactViewModel> Contact { get; set; }
        public virtual ICollection<AddressViewModel> Address { get; set; }
        public int? IdItem { get; set; }

        public CompanyViewModel()
        {

        }
    }
}
