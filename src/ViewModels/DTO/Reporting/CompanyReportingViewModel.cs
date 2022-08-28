using System;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.Reporting
{
    /// <summary>
    /// report infoamtions view model
    /// </summary>
    [Serializable]
    public class CompanyReportingViewModel
    {
        //Company infos
        public string Adress { get; set; } = string.Empty;
        public ZipCodeViewModel IdZipCodeNavigation { get; set; }
        public virtual CityViewModel IdCityNavigation { get; set; }
        public virtual CountryViewModel IdCountryNavigation { get; set; }
        public string Tel1 { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string Siret { get; set; } = string.Empty;
        public string CommercialRegister { get; set; } = string.Empty;
        public string VatNumber { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string WebSite { get; set; } = string.Empty;
        public string CompanyLogo { get; set; } = string.Empty;
        public string MatriculeFisc { get; set; } = string.Empty;

    }
}
