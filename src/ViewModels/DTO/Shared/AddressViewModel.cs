using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Shared
{
    public class AddressViewModel : GenericViewModel
    {
       
        public string ExtraAdress { get; set; }
        public int? IdTiers { get; set; }
        public int? IdOffice { get; set; }
        public int? IdContact { get; set; }
        public string DeletedToken { get; set; }
        public string PrincipalAddress { get; set; }
        
        public string Label { get; set; }
        public int? IdCountry { get; set; }
        public int? IdCompany { get; set; }
        public int? IdCity { get; set; }
        public int? IdZipCode { get; set; }
        public string Region { get; set; }
        public string CodeZip { get; set; }
        public virtual CityViewModel IdCityNavigation { get; set; }
        public virtual CompanyViewModel IdCompanyNavigation { get; set; }
        public TiersViewModel IdTiersNavigation { get; set; }
        public ICollection<ContactViewModel> Contact { get; set; }
        public virtual CountryViewModel IdCountryNavigation { get; set; }
        public virtual ZipCodeViewModel IdZipCodeNavigation { get; set; }

    }
}
