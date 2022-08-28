using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Reporting.Interfaces;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Reporting.Classes
{
    public class CompanyReportingBuilder : GenericBuilder<CompanyReportingViewModel, Company>, ICompanyReportingBuilder
    {


        public override CompanyReportingViewModel BuildEntity(Company entity)
        {

            CompanyReportingViewModel model = base.BuildEntity(entity);

            // Set zipCode
            if (model.IdZipCodeNavigation == null)
            {
                model.IdZipCodeNavigation = new ZipCodeViewModel();
            }
            // Affect code of zipCode if null
            if (model.IdZipCodeNavigation.Code == null)
            {
                model.IdZipCodeNavigation.Code = string.Empty;
            }


            // Set city
            if (model.IdCityNavigation == null)
            {
                model.IdCityNavigation = new CityViewModel();
            }
            // Affect label of city if null
            if (model.IdCityNavigation.Label == null)
            {
                model.IdCityNavigation.Label = string.Empty;
            }


            // Set country
            if (model.IdCountryNavigation == null)
            {
                model.IdCountryNavigation = new CountryViewModel();
            }
            // Affect NameFr of country if null
            if (model.IdCountryNavigation.NameFr == null)
            {
                model.IdCountryNavigation.NameFr = string.Empty;
            }
            // Affect NameEn of country if null
            if (model.IdCountryNavigation.NameEn == null)
            {
                model.IdCountryNavigation.NameEn = string.Empty;
            }

            return model;
        }

    }
}
