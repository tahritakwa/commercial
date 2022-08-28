using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.Shared
{

    public class CityViewModel : GenericViewModel
    {
        public string Code { get; set; }
        public string Label { get; set; }
        public int? IdCountry { get; set; }
        public CountryViewModel IdCountryNavigation { get; set; }
    }
}
